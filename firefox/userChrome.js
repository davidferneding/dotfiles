// ==UserScript==
// @name            TitlebarButtonFix
// @version         1.0
// @author          fernedingd
// @description     Moves the window action buttons (close/min/max) from the titlebar to the navbar
// @grant           unsafeWindow
// ==/UserScript==

let navbar = unsafeWindow.document.querySelector('#nav-bar');
let buttons = unsafeWindow.document.querySelector('.titlebar-buttonbox-container');
navbar.insertAdjacentElement('afterbegin', buttons);
