(function() {
    "use strict";

    function enableInteraction() {
        // Remove `inert` attribute and enable text selection
        document.querySelectorAll('[inert]').forEach(el => {
            el.removeAttribute('inert');
            el.style.userSelect = 'text';
        });

        // Enable disabled inputs and set pointer cursor
        document.querySelectorAll('input:disabled').forEach(input => {
            input.disabled = false;
            input.style.cursor = 'pointer';
        });

        // Enable copy-paste functionality by removing restrictions
        document.querySelectorAll('[oncopy], [onpaste], [oncut]').forEach(el => {
            el.removeAttribute('oncopy');
            el.removeAttribute('onpaste');
            el.removeAttribute('oncut');
        });

        // Allow text selection on elements that restrict it via styles
        document.querySelectorAll('[style*="user-select: none"]').forEach(el => {
            el.style.userSelect = 'text';
        });

        // Make MathJax content copy-pasteable
        document.querySelectorAll('mjx-container, mjx-math, mjx-assistive-mml').forEach(el => {
            el.style.userSelect = 'text';
            el.removeAttribute('unselectable');
        });

        // Re-render MathJax if available
        if (typeof MathJax !== 'undefined' && MathJax.typeset) {
            MathJax.typeset();
        }
    }

    // Create style element to enforce copy-paste abilities
    const style = document.createElement('style');
    style.textContent = `
        * {
            -webkit-user-select: text !important;
            -moz-user-select: text !important;
            -ms-user-select: text !important;
            user-select: text !important;
            -webkit-touch-callout: default !important;
        }
        [oncopy], [onpaste], [oncut] {
            -webkit-user-select: text !important;
            -moz-user-select: text !important;
            -ms-user-select: text !important;
            user-select: text !important;
        }
    `;
    document.head?.appendChild(style);

    // Run immediately and observe for changes
    enableInteraction();
    new MutationObserver(enableInteraction).observe(document.body, {
        childList: true,
        subtree: true
    });

    // Override copy protection methods
    document.addEventListener('copy', (e) => e.stopImmediatePropagation(), true);
    document.addEventListener('paste', (e) => e.stopImmediatePropagation(), true);
    document.addEventListener('cut', (e) => e.stopImmediatePropagation(), true);
})(); 
