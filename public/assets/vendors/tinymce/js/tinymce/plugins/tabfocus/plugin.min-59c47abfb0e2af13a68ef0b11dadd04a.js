tinymce.PluginManager.add("tabfocus",function(e){function n(e){9===e.keyCode&&e.preventDefault()}function t(n){function t(n){function t(e){return"BODY"===e.nodeName||"hidden"!=e.type&&"none"!=e.style.display&&"hidden"!=e.style.visibility&&t(e.parentNode)}function r(e){return e.tabIndex||"INPUT"==e.nodeName||"TEXTAREA"==e.nodeName}function a(e){return!r(e)&&"-1"!=e.getAttribute("tabindex")&&t(e)}if(d=i.select(":input:enabled,*[tabindex]:not(iframe)"),o(d,function(n,t){return n.id==e.id?(u=t,!1):void 0}),n>0){for(c=u+1;c<d.length;c++)if(a(d[c]))return d[c]}else for(c=u-1;c>=0;c--)if(a(d[c]))return d[c];return null}var u,d,a,c;if(9===n.keyCode&&(a=r(e.getParam("tab_focus",e.getParam("tabfocus_elements",":prev,:next"))),1==a.length&&(a[1]=a[0],a[0]=":prev"),d=n.shiftKey?":prev"==a[0]?t(-1):i.get(a[0]):":next"==a[1]?t(1):i.get(a[1]))){var f=tinymce.get(d.id||d.name);d.id&&f?f.focus():window.setTimeout(function(){tinymce.Env.webkit||window.focus(),d.focus()},10),n.preventDefault()}}var i=tinymce.DOM,o=tinymce.each,r=tinymce.explode;e.on("init",function(){e.inline&&tinymce.DOM.setAttrib(e.getBody(),"tabIndex",null)}),e.on("keyup",n),tinymce.Env.gecko?e.on("keypress keydown",t):e.on("keydown",t)});
