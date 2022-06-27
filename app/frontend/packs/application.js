// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import '../js/bootstrap_js_files.js'

Rails.start()
Turbolinks.start()
ActiveStorage.start()
// var codeEditor = document.getElementById('codeEditor');
// var lineCounter = document.getElementById('lineCounter');
//
// codeEditor.addEventListener('scroll', () => {
//     lineCounter.scrollTop = codeEditor.scrollTop;
//     lineCounter.scrollLeft = codeEditor.scrollLeft;
// });
//
// var lineCountCache = 0;
// function line_counter() {
//     var lineCount = codeEditor.value.split('\n').length;
//     var outarr = new Array();
//     if (lineCountCache != lineCount) {
//         for (var x = 0; x < lineCount; x++) {
//             outarr[x] = (x + 1) + '.';
//         }
//         lineCounter.value = outarr.join('\n');
//     }
//     lineCountCache = lineCount;
// }
// codeEditor.addEventListener('input', () => {
//     line_counter();
// });