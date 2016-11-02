tinymce.PluginManager.add("lists",function(e){var t=this;e.on("init",function(){function n(e){function t(t){var i,r,a;r=e[t?"startContainer":"endContainer"],a=e[t?"startOffset":"endOffset"],1==r.nodeType&&(i=b.create("span",{"data-mce-type":"bookmark"}),r.hasChildNodes()?(a=Math.min(a,r.childNodes.length-1),r.insertBefore(i,r.childNodes[a])):r.appendChild(i),r=i,a=0),n[t?"startContainer":"endContainer"]=r,n[t?"startOffset":"endOffset"]=a}var n={};return t(!0),e.collapsed||t(),n}function i(t){function n(n){function i(e){for(var t=e.parentNode.firstChild,n=0;t;){if(t==e)return n;(1!=t.nodeType||"bookmark"!=t.getAttribute("data-mce-type"))&&n++,t=t.nextSibling}return-1}var r,a,o;if(r=o=t[n?"startContainer":"endContainer"],a=t[n?"startOffset":"endOffset"],r){if(1==r.nodeType){if(r.parentNode==e.getBody()){var s,l=e.settings.forced_root_block;l?(s=b.create(l),(!tinymce.Env.ie||tinymce.Env.ie>10)&&s.appendChild(b.create("br",{"data-mce-bogus":"true"})),r.parentNode.insertBefore(s,r),r=s,a=0):(s=b.create("br"),r.parentNode.insertBefore(s,r),r=r.parentNode,a=i(s))}else n?(a=i(r),r=r.parentNode):(a=i(r),r=r.parentNode);b.remove(o)}t[n?"startContainer":"endContainer"]=r,t[n?"startOffset":"endOffset"]=a}}n(!0),n();var i=b.createRng();i.setStart(t.startContainer,t.startOffset),t.endContainer&&i.setEnd(t.endContainer,t.endOffset),C.setRng(i)}function r(e){return e&&/^(OL|UL)$/.test(e.nodeName)}function a(e){return e.parentNode.firstChild==e}function o(e){return e.parentNode.lastChild==e}function s(t){return t&&!!e.schema.getTextBlockElements()[t.nodeName]}function l(t,n){var i,r;if(e.settings.forced_root_block&&(n=n||e.settings.forced_root_block),r=n?b.create(n):b.createFragment(),t)for(;i=t.firstChild;)r.appendChild(i);return e.settings.forced_root_block||r.appendChild(b.create("br")),r.hasChildNodes()||tinymce.Env.ie&&!(tinymce.Env.ie>10)||(r.innerHTML='<br data-mce-bogus="1">'),r}function c(){return tinymce.grep(C.getSelectedBlocks(),function(e){return"LI"==e.nodeName})}function d(){return tinymce.grep(C.getSelectedBlocks(),s)}function u(e,t,n){var i,r,a=b.select('span[data-mce-type="bookmark"]',e);n=n||l(t),i=b.createRng(),i.setStartAfter(t),i.setEndAfter(e),r=i.extractContents(),b.isEmpty(r)||b.insertAfter(r,e),b.isEmpty(n)||b.insertAfter(n,e),b.isEmpty(t.parentNode)&&(tinymce.each(a,function(e){t.parentNode.parentNode.insertBefore(e,t.parentNode)}),b.remove(t.parentNode)),b.remove(t)}function m(e){var t,n;if(t=e.nextSibling,t&&r(t)&&t.nodeName==e.nodeName){for(;n=t.firstChild;)e.appendChild(n);b.remove(t)}if(t=e.previousSibling,t&&r(t)&&t.nodeName==e.nodeName){for(;n=t.firstChild;)e.insertBefore(n,e.firstChild);b.remove(t)}}function f(e){tinymce.each(tinymce.grep(b.select("ol,ul",e)),function(e){var t,n=e.parentNode;"LI"==n.nodeName&&n.firstChild==e&&(t=n.previousSibling,t&&"LI"==t.nodeName&&(t.appendChild(e),b.isEmpty(n)&&b.remove(n))),r(n)&&(t=n.previousSibling,t&&"LI"==t.nodeName&&t.appendChild(e))})}function p(){var e,t=n(C.getRng(!0));return tinymce.each(c(),function(t){var n,i;return n=t.previousSibling,n&&"UL"==n.nodeName?(n.appendChild(t),void 0):n&&"LI"==n.nodeName&&r(n.lastChild)?(n.lastChild.appendChild(t),void 0):(n=t.nextSibling,n&&"UL"==n.nodeName?(n.insertBefore(t,n.firstChild),void 0):(n&&"LI"==n.nodeName&&r(t.lastChild)||(n=t.previousSibling,n&&"LI"==n.nodeName&&(i=b.create(t.parentNode.nodeName),n.appendChild(i),i.appendChild(t)),e=!0),void 0))}),i(t),e}function h(){function e(e){b.isEmpty(e)&&b.remove(e)}var t,s=n(C.getRng(!0));return tinymce.each(c(),function(n){var i,s=n.parentNode,c=s.parentNode;if(a(n)&&o(n))if("LI"==c.nodeName)b.insertAfter(n,c),e(c);else{if(!r(c))return;b.remove(s,!0)}else if(a(n))if("LI"==c.nodeName)b.insertAfter(n,c),i=b.create("LI"),i.appendChild(s),b.insertAfter(i,n),e(c);else{if(!r(c))return;c.insertBefore(n,s)}else if(o(n))if("LI"==c.nodeName)b.insertAfter(n,c);else{if(!r(c))return;b.insertAfter(n,s)}else{if("LI"==c.nodeName)s=c,i=l(n,"LI");else{if(!r(c))return;i=l(n,"LI")}u(s,n,i),f(s.parentNode)}t=!0}),i(s),t}function g(t){function a(){function t(t){var n,i,r=e.getBody();for(n=o[t?"startContainer":"endContainer"],i=o[t?"startOffset":"endOffset"],1==n.nodeType&&(n=n.childNodes[Math.min(i,n.childNodes.length-1)]||n);n.parentNode!=r;){if(s(n))return n;if(/^(TD|TH)$/.test(n.parentNode.nodeName))return n;n=n.parentNode}return n}function n(e,t){var n,i=[];if(!s(e)){for(;e&&(n=e[t?"previousSibling":"nextSibling"],!b.isBlock(n)&&n);)e=n;for(;e;)i.push(e),e=e[t?"nextSibling":"previousSibling"]}return i}var i,r,a=t(!0),l=t();r=n(a,!0),a!=l&&(r=r.concat(n(l).reverse())),tinymce.each(r,function(e){if(!b.isBlock(e)||"BR"==e.nodeName){if(!i||"BR"==e.nodeName){if("BR"==e.nodeName&&(!e.nextSibling||b.isBlock(e.nextSibling)&&"BR"!=e.nextSibling.nodeName))return b.remove(e),!1;i=b.create("p"),c.push(i),e.parentNode.insertBefore(i,e)}return"BR"!=e.nodeName?i.appendChild(e):b.remove(e),e==l?!1:void 0}})}var o=C.getRng(!0),l=n(o),c=d();a(),tinymce.each(c,function(e){var n,i;i=e.previousSibling,i&&r(i)&&i.nodeName==t?(n=i,e=b.rename(e,"LI"),i.appendChild(e)):(n=b.create(t),e.parentNode.insertBefore(n,e),n.appendChild(e),e=b.rename(e,"LI")),m(n)}),i(l)}function v(){var e=n(C.getRng(!0));tinymce.each(c(),function(e){var t,n;for(t=e;t;t=t.parentNode)r(t)&&(n=t);u(n,e)}),i(e)}function y(e){var t=b.getParent(C.getStart(),"OL,UL");if(t)if(t.nodeName==e)v(e);else{var r=n(C.getRng(!0));m(b.rename(t,e)),i(r)}else g(e)}var b=e.dom,C=e.selection;t.backspaceDelete=function(e){function t(e,t){var n=e.startContainer,i=e.startOffset;if(3==n.nodeType&&(t?i<n.data.length:i>0))return n;for(var r=new tinymce.dom.TreeWalker(e.startContainer);n=r[t?"next":"prev"]();)if(3==n.nodeType&&n.data.length>0)return n}function a(e,t){var n,i,a=e.parentNode;for(r(t.lastChild)&&(i=t.lastChild),n=t.lastChild,n&&"BR"==n.nodeName&&e.hasChildNodes()&&b.remove(n);n=e.firstChild;)t.appendChild(n);i&&t.appendChild(i),b.remove(e),b.isEmpty(a)&&b.remove(a)}if(C.isCollapsed()){var o=b.getParent(C.getStart(),"LI");if(o){var s=C.getRng(!0),l=b.getParent(t(s,e),"LI");if(l&&l!=o){var c=n(s);return e?a(l,o):a(o,l),i(c),!0}if(!l&&!e&&v(o.parentNode.nodeName))return!0}}},e.addCommand("Indent",function(){return p()?void 0:!0}),e.addCommand("Outdent",function(){return h()?void 0:!0}),e.addCommand("InsertUnorderedList",function(){y("UL")}),e.addCommand("InsertOrderedList",function(){y("OL")})}),e.on("keydown",function(e){e.keyCode==tinymce.util.VK.BACKSPACE?t.backspaceDelete()&&e.preventDefault():e.keyCode==tinymce.util.VK.DELETE&&t.backspaceDelete(!0)&&e.preventDefault()})});
