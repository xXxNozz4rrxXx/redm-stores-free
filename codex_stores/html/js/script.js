const RESOURCE_NAME = (typeof GetParentResourceName === 'function') ? GetParentResourceName() : 'codex_stores';

function postNui(callbackName, payload) {
    return fetch(`https://${RESOURCE_NAME}/${callbackName}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload || {})
    });
}

let openedUIType = null;
let selectedCategory = null;
let selectedStoreTransactionType = null;
let selectedItem = null;
let selectedItemCost = null;
let selectedItemCurrencyType = null;
let selectedItemId = 0;
let pressedToBuyCooldown = false;

function setHtml(id, html) {
    const element = document.getElementById(id);
    if (element) element.innerHTML = html;
}

function appendHtml(id, html) {
    const element = document.getElementById(id);
    if (element) element.insertAdjacentHTML('beforeend', html);
}

function clearHtml(id) {
    setHtml(id, '');
}

function escapeHtml(value) {
    return String(value ?? '')
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#039;');
}

function escapeAttr(value) {
    return escapeHtml(value).replace(/`/g, '&#096;');
}

function normaliseLookup(value) {
    return String(value || '').toLowerCase().replace(/[^a-z0-9]+/g, '_').replace(/^_+|_+$/g, '');
}


function getIconMarkup(iconType) {
    const icons = {
        tools: `<svg viewBox="0 0 64 64" aria-hidden="true"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M38 12c5 0 9 2 12 5l-8 8 5 5 8-8c3 8-3 17-12 18-3 1-6 0-9-1L22 57l-6-6 18-24c-1-3-2-6-1-9 1-4 2-6 5-6z"/><path d="M14 18l12 12"/><path d="M22 10l8 8"/></g></svg>`,
        food: `<svg viewBox="0 0 64 64" aria-hidden="true"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M24 21c2 2 14 2 16 0"/><path d="M27 21c0-5 2-8 5-10 3 2 5 5 5 10"/><path d="M20 26l4 26h16l4-26c-6 4-18 4-24 0z"/><path d="M26 52h12"/></g></svg>`,
        goods: `<svg viewBox="0 0 64 64" aria-hidden="true"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M14 22l18-9 18 9-18 9z"/><path d="M14 22v20l18 9 18-9V22"/><path d="M32 31v20"/></g></svg>`,
        weapon: `<svg viewBox="0 0 64 64" aria-hidden="true"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M18 46l12-12 8 8-12 12H18z"/><path d="M38 26l10-10"/><path d="M44 20l4-4"/></g></svg>`,
        herbal: `<svg viewBox="0 0 64 64" aria-hidden="true"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M32 54V18"/><path d="M32 31C21 31 15 24 14 13c11 0 18 7 18 18z"/><path d="M32 37c11 0 17-7 18-18-11 0-18 7-18 18z"/></g></svg>`,
        fishing: `<svg viewBox="0 0 64 64" aria-hidden="true"><g fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M15 20c10 0 17 7 17 18"/><path d="M32 38c0 7 5 12 11 12 5 0 10-3 10-8 0-4-2-7-6-9l-5-3"/><path d="M41 22c-4 3-5 9-2 13 3 4 8 5 12 2 4-3 5-9 2-13-3-4-8-5-12-2z"/></g></svg>`,
        buy: `<svg viewBox="0 0 64 64" aria-hidden="true"><path d="M32 14v36M14 32h36" fill="none" stroke="currentColor" stroke-width="3.5" stroke-linecap="round"/></svg>`,
        sell: `<svg viewBox="0 0 64 64" aria-hidden="true"><path d="M16 32h32" fill="none" stroke="currentColor" stroke-width="3.5" stroke-linecap="round"/></svg>`
    };

    return icons[iconType] || icons.goods;
}

function getCategoryMeta(label) {
    const key = normaliseLookup(label);
    const meta = {
        tools: { icon: 'tools', desc: 'Hardware, equipment & workshop essentials.' },
        tool: { icon: 'tools', desc: 'Hardware, equipment & workshop essentials.' },
        food: { icon: 'food', desc: 'Provisions, ingredients & daily necessities.' },
        foods: { icon: 'food', desc: 'Provisions, ingredients & daily necessities.' },
        goods: { icon: 'goods', desc: 'General goods, supplies & useful trade items.' },
        all: { icon: 'goods', desc: 'Browse every item available in this store.' },
        weapons: { icon: 'weapon', desc: 'Weapon stock and ammunition supplies.' },
        weapon: { icon: 'weapon', desc: 'Weapon stock and ammunition supplies.' },
        herbal: { icon: 'herbal', desc: 'Seeds, herbs & farming supplies.' },
        herbs: { icon: 'herbal', desc: 'Seeds, herbs & farming supplies.' },
        fishing: { icon: 'fishing', desc: 'Bait, tackle & fishing supplies.' },
        fish: { icon: 'fishing', desc: 'Bait, tackle & fishing supplies.' },
        buy: { icon: 'buy', desc: 'Purchase stock from this store.' },
        sell: { icon: 'sell', desc: 'Sell matching goods from your inventory.' },
    };

    return meta[key] || { icon: 'goods', desc: 'Browse this department and available stock.' };
}

function createMenuCard(buttonId, className, label, attrLabel) {
    const meta = getCategoryMeta(label);
    return `
        <button type="button" id="${buttonId}" class="store-row ${className}" category="${attrLabel}">
            <span class="category-icon icon-${escapeAttr(meta.icon)}">${getIconMarkup(meta.icon)}</span>
            <span class="category-copy">
                <span class="category-name">${escapeHtml(label)}</span>
                <span class="category-desc">${escapeHtml(meta.desc)}</span>
            </span>
            <span class="category-arrow">›</span>
        </button>
    `;
}

function formatPrice(price, currency) {
    const value = Number(price);
    const displayValue = Number.isFinite(value) ? value.toFixed(value % 1 === 0 ? 0 : 2) : String(price ?? 0);

    if (currency === 'cents') return `${displayValue}¢`;
    if (currency === 'gold') return `${displayValue} ${Locales.Gold || 'Gold'}`;
    if (currency === 'dollars' || !currency) return `$${displayValue}`;

    return `${displayValue} ${currency}`;
}

function normaliseAmount(value) {
    const amount = parseInt(value, 10);
    return Number.isFinite(amount) && amount > 0 ? amount : 1;
}

function setAmount(value) {
    const amountInput = document.getElementById('products_item_amount_input');
    if (!amountInput) return;
    amountInput.value = normaliseAmount(value);
}

function resetSelection() {
    selectedItemId = 0;
    selectedItem = null;
    selectedItemCost = null;
    selectedItemCurrencyType = null;

    document.querySelectorAll('.product-card.is-selected').forEach((card) => card.classList.remove('is-selected'));

    const selectedDisplay = document.getElementById('products_selected_item_display');
    if (selectedDisplay && typeof Locales !== 'undefined') {
        selectedDisplay.style.color = 'var(--ui-accent-red)';
        selectedDisplay.innerHTML = Locales.NotSelected;
    }

    setAmount(1);
}

function clearMenus() {
    clearHtml('categories');
    clearHtml('types');
    clearHtml('products');
    clearHtml('objects');

    const searchInput = document.getElementById('products_search_input');
    if (searchInput) searchInput.value = '';
}

function closeNUI() {
    clearMenus();

    openedUIType = null;
    selectedCategory = null;
    selectedStoreTransactionType = null;
    pressedToBuyCooldown = false;

    displayPage('categories_menu', 'visible');
    displayPage('buttons', 'hidden');
    displayPage('type_categories_menu', 'hidden');
    displayPage('category_products', 'hidden');
    displayPage('object_dialog', 'hidden');

    setHtml('object_dialog_model_title', '');
    resetSelection();

    const enableShop = document.getElementById('enable_shop');
    if (enableShop) enableShop.style.display = 'none';

    document.body.style.display = 'none';
    postNui('closeNUI', {});
}

function playAudio(sound) {
    try {
        const audio = new Audio('./audio/' + sound);
        audio.volume = Config.DefaultClickSoundVolume;
        audio.play().catch(() => {});
    } catch (error) {}
}

const loadScript = (fileUrl, async = true, type = 'text/javascript') => {
    return new Promise((resolve, reject) => {
        try {
            const scriptElement = document.createElement('script');
            scriptElement.type = type;
            scriptElement.async = async;
            scriptElement.src = fileUrl;
            scriptElement.addEventListener('load', () => resolve({ status: true }));
            scriptElement.addEventListener('error', () => reject({ status: false, message: `Failed to load the script ${fileUrl}` }));
            document.body.appendChild(scriptElement);
        } catch (error) {
            reject(error);
        }
    });
};

loadScript('js/locales/locales-' + Config.Locale + '.js').then(() => {
    displayPage('categories_menu', 'visible');
    displayPage('buttons', 'hidden');
    displayPage('type_categories_menu', 'hidden');
    displayPage('object_dialog', 'hidden');
    displayPage('category_products', 'hidden');

    resetSelection();
    setHtml('object_dialog_display_button', Locales.Display);
    setHtml('shop_back_button', Locales.Back);
}).catch((error) => console.error(error));

window.addEventListener('message', function (event) {
    const item = event.data;

    if (item.type === 'enable_shop') {
        document.body.style.display = item.enable ? 'flex' : 'none';
        const enableShop = document.getElementById('enable_shop');
        if (enableShop) enableShop.style.display = item.enable ? 'block' : 'none';
        return;
    }

    if (item.action === 'updateStoreHeaderTitle') {
        setHtml('shop_opened_title_display', escapeHtml(item.header));
        setHtml('shop_opened_title_footer', escapeHtml(item.footer));
        return;
    }

    if (item.action === 'updatePlayerAccountInformation') {
        const account = item.accounts || {};
        setHtml('player_account_information_text', `${Locales.YouHave || 'You have '}$${escapeHtml(account.dollars || 0)}`);
        return;
    }

    if (item.action === 'clearStoreCategories') {
        clearHtml('categories');
        return;
    }

    if (item.action === 'clearStoreCategoryTypes') {
        clearHtml('types');
        return;
    }

    if (item.action === 'clearStoreCategoryProducts') {
        clearHtml('products');
        resetSelection();
        return;
    }

    if (item.action === 'addStoreCategories') {
        const label = escapeHtml(item.label);
        const attrLabel = escapeAttr(item.label);
        appendHtml('categories', createMenuCard('categories_category_name', 'category-card', item.label, attrLabel));
        openedUIType = 'store_categories';
        return;
    }

    if (item.action === 'addStoreCategoryTypes') {
        const label = escapeHtml(item.label);
        const attrLabel = escapeAttr(item.label);
        appendHtml('types', createMenuCard('type_categories_category_name', 'type-card', item.label, attrLabel));
        displayPage('type_categories_menu', 'visible');
        openedUIType = 'store_type_categories';
        return;
    }

    if (item.action === 'addStoreSelectedCategoryProducts') {
        const product = item.item_data;
        openedUIType = 'store_products';
        displayPage('category_products', 'visible');

        const itemId = product.id || 0;
        const itemImage = getItemIMG(product.item);
        const label = escapeHtml(product.label || product.item || 'Item');
        const attrLabel = escapeAttr(product.label || product.item || 'Item');
        const attrCurrency = escapeAttr(product.currency || 'dollars');
        const attrCost = escapeAttr(product.price || 0);
        const attrItem = escapeAttr(product.item || '');
        const category = escapeHtml(product.category || 'goods');
        const priceDisplay = escapeHtml(formatPrice(product.price, product.currency));

        if (product.hasRequiredLevel) {
            appendHtml('products', `
                <article class="product-card" data-search="${attrLabel.toLowerCase()} ${attrItem.toLowerCase()} ${escapeAttr(category).toLowerCase()}">
                    <div id="products_item_image_display" class="product-icon">
                        <img src="${escapeAttr(itemImage)}" alt="${attrLabel}" onerror="this.style.display='none'; this.parentElement.classList.add('missing-icon');" />
                    </div>
                    <div class="product-info">
                        <div id="products_item_label" class="product-title">${label}</div>
                        <div id="products_item_cost" class="product-price">${priceDisplay}</div>
                        <div class="product-meta">${category}</div>
                    </div>
                    <button type="button" id="products_select_button" class="select-product-btn" label="${attrLabel}" currency="${attrCurrency}" cost="${attrCost}" itemid="${escapeAttr(itemId)}" item="${attrItem}">${Locales.Select}</button>
                </article>
            `);
        } else {
            appendHtml('products', `
                <article class="product-card is-locked" data-search="${attrLabel.toLowerCase()} ${attrItem.toLowerCase()} ${escapeAttr(category).toLowerCase()}">
                    <div id="products_item_image_display" class="product-icon">
                        <img src="${escapeAttr(itemImage)}" alt="${attrLabel}" onerror="this.style.display='none'; this.parentElement.classList.add('missing-icon');" />
                    </div>
                    <div class="product-info">
                        <div id="products_item_label" class="product-title locked-text">${label}</div>
                        <div id="products_item_cost" class="product-price locked-text">${escapeHtml(product.requiredLevel || 1)} Knowledge Level Required</div>
                        <div class="product-meta">Locked</div>
                    </div>
                </article>
            `);
        }
        return;
    }

    if (item.action === 'closeUI') closeNUI();
});

window.addEventListener('message', function (event) {
    if (event.data.type === 'itemCount') {
        setAmount(event.data.count);
    }
});

document.addEventListener('keyup', function (key) {
    if (key.which !== 27) return;

    resetSelection();

    if (openedUIType === 'store_products') {
        playAudio('button_click.wav');
        displayPage('category_products', 'hidden');
        clearHtml('products');
        clearHtml('types');
        postNui('loadStoreTypeCategories', { category: selectedCategory });
    } else if (openedUIType === 'store_type_categories') {
        playAudio('button_click.wav');
        displayPage('buttons', 'hidden');
        displayPage('type_categories_menu', 'hidden');
        displayPage('categories_menu', 'visible');
        clearHtml('categories');
        clearHtml('types');
        postNui('loadCategories', { category: selectedCategory });
    } else if (openedUIType === 'store_categories') {
        closeNUI();
    }
});

document.addEventListener('input', function (event) {
    const target = event.target;

    if (target.matches('#products_search_input')) {
        const query = target.value.trim().toLowerCase();
        document.querySelectorAll('.product-card').forEach((card) => {
            const haystack = card.getAttribute('data-search') || '';
            card.classList.toggle('hidden-by-search', query !== '' && !haystack.includes(query));
        });
        return;
    }

    if (target.matches('#products_item_amount_input')) {
        const cleaned = target.value.replace(/[^0-9]/g, '');
        target.value = cleaned === '' ? '' : cleaned;
    }
});

document.addEventListener('click', function (event) {
    const target = event.target;
    const categoryButton = target.closest('#categories_category_name');
    const typeButton = target.closest('#type_categories_category_name');
    const selectButton = target.closest('#products_select_button');

    if (target.closest('#shop_back_button')) {
        playAudio('button_click.wav');
        resetSelection();

        if (openedUIType === 'store_products') {
            displayPage('category_products', 'hidden');
            clearHtml('products');
            clearHtml('types');
            postNui('loadStoreTypeCategories', { category: selectedCategory });
        } else if (openedUIType === 'store_type_categories') {
            displayPage('buttons', 'hidden');
            displayPage('type_categories_menu', 'hidden');
            displayPage('categories_menu', 'visible');
            clearHtml('categories');
            clearHtml('types');
            postNui('loadCategories', { category: selectedCategory });
        }
        return;
    }

    if (categoryButton) {
        playAudio('button_click.wav');
        selectedCategory = categoryButton.getAttribute('category');
        displayPage('categories_menu', 'hidden');
        postNui('loadStoreTypeCategories', { category: selectedCategory });
        displayPage('buttons', 'visible');
        return;
    }

    if (typeButton) {
        playAudio('button_click.wav');
        const transactionType = typeButton.getAttribute('category');
        displayPage('type_categories_menu', 'hidden');

        if (transactionType === 'buy') {
            setHtml('products_action_button', Locales.Buy);
            selectedStoreTransactionType = 'buy';
        } else if (transactionType === 'sell') {
            setHtml('products_action_button', Locales.Sell);
            selectedStoreTransactionType = 'sell';
        }

        postNui('loadStoreTypeCategoryProducts', { category: transactionType });
        displayPage('buttons', 'visible');
        return;
    }

    if (selectButton) {
        playAudio('button_click.wav');

        selectedItemId = selectButton.getAttribute('itemid');
        selectedItem = selectButton.getAttribute('item');
        selectedItemCost = selectButton.getAttribute('cost');
        selectedItemCurrencyType = selectButton.getAttribute('currency');

        setAmount(1);

        if (selectedStoreTransactionType === 'sell') {
            postNui('getItemCount', { itemName: selectedItem });
        }

        document.querySelectorAll('.product-card.is-selected').forEach((card) => card.classList.remove('is-selected'));
        const productCard = selectButton.closest('.product-card');
        if (productCard) productCard.classList.add('is-selected');

        const selectedDisplay = document.getElementById('products_selected_item_display');
        selectedDisplay.style.color = 'var(--codex-gold-soft)';
        selectedDisplay.innerHTML = escapeHtml(selectButton.getAttribute('label'));
        return;
    }

    if (target.closest('#amount_minus_button')) {
        playAudio('button_click.wav');
        const amountInput = document.getElementById('products_item_amount_input');
        setAmount(normaliseAmount(amountInput.value) - 1);
        return;
    }

    if (target.closest('#amount_plus_button')) {
        playAudio('button_click.wav');
        const amountInput = document.getElementById('products_item_amount_input');
        setAmount(normaliseAmount(amountInput.value) + 1);
        return;
    }

    if (target.closest('#products_action_button')) {
        playAudio('button_click.wav');
        performSelectedProductAction();
    }
});

document.addEventListener('DOMContentLoaded', function () {
    const amountInput = document.getElementById('products_item_amount_input');
    if (!amountInput) return;

    amountInput.onkeypress = function (event) {
        const keyCode = event.code || event.key;

        if (keyCode !== 'Enter' && keyCode !== 'NumpadEnter') return true;

        if (!pressedToBuyCooldown) {
            pressedToBuyCooldown = true;
            playAudio('button_click.wav');
            performSelectedProductAction();
            setTimeout(function () { pressedToBuyCooldown = false; }, 2000);
        }

        return false;
    };

    amountInput.addEventListener('blur', function () {
        setAmount(amountInput.value);
    });
});

function performSelectedProductAction() {
    const labelElement = document.getElementById('products_selected_item_display');
    const amountInput = document.getElementById('products_item_amount_input');
    const label = labelElement.innerHTML;
    const amount = normaliseAmount(amountInput.value);

    if (label === Locales.NotSelected || !selectedItem) return;

    postNui('performActionOnSelectedProduct', {
        itemid: selectedItemId,
        item: selectedItem,
        label: labelElement.textContent,
        quantity: amount,
        cost: selectedItemCost,
        currency: selectedItemCurrencyType,
        category: selectedStoreTransactionType,
    });

    setAmount(1);
}

function displayPage(page, visibility) {
    const elements = document.querySelectorAll('.' + page);
    elements.forEach((element) => {
        element.style.visibility = visibility;
        element.style.pointerEvents = visibility === 'visible' ? 'auto' : 'none';
    });
}

function onNumbers(evt) {
    const asciiCode = evt.which ? evt.which : evt.keyCode;
    return !(asciiCode > 31 && (asciiCode < 48 || asciiCode > 57));
}

function getItemIMG(item) {
    return (Config.InventoryImagePath || 'nui://vorp_inventory/html/img/items/') + item + '.png';
}
