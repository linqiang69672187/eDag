function lqdivCenter(div) {
    div.style.left = (parseFloat(document.body.offsetWidth) - parseFloat(div.style.width)) / 2 + "px";
    div.style.top = (parseFloat(window.screen.availHeight) - parseFloat(div.style.height)) / 2 + "px";
}
