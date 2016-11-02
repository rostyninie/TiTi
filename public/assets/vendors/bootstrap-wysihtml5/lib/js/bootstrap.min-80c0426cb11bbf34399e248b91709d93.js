/**
* Bootstrap.js by @fat & @mdo
* Copyright 2012 Twitter, Inc.
* http://www.apache.org/licenses/LICENSE-2.0.txt
*/

!function(b){var a=function(c,d){this.options=b.extend({},b.fn.affix.defaults,d);this.$window=b(window).on("scroll.affix.data-api",b.proxy(this.checkPosition,this)).on("click.affix.data-api",b.proxy(function(){setTimeout(b.proxy(this.checkPosition,this),1)},this));this.$element=b(c);this.checkPosition()};a.prototype.checkPosition=function(){if(!this.$element.is(":visible")){return}var i=b(document).height(),c=this.$window.scrollTop(),d=this.$element.offset(),j=this.options.offset,h=j.bottom,f=j.top,e="affix affix-top affix-bottom",g;if(typeof j!="object"){h=f=j}if(typeof f=="function"){f=j.top()}if(typeof h=="function"){h=j.bottom()}g=this.unpin!=null&&(c+this.unpin<=d.top)?false:h!=null&&(d.top+this.$element.height()>=i-h)?"bottom":f!=null&&c<=f?"top":false;if(this.affixed===g){return}this.affixed=g;this.unpin=g=="bottom"?d.top-c:null;this.$element.removeClass(e).addClass("affix"+(g?"-"+g:""))};b.fn.affix=function(c){return this.each(function(){var e=b(this),f=e.data("affix"),d=typeof c=="object"&&c;if(!f){e.data("affix",(f=new a(this,d)))}if(typeof c=="string"){f[c]()}})};b.fn.affix.Constructor=a;b.fn.affix.defaults={offset:0};b(window).on("load",function(){b('[data-spy="affix"]').each(function(){var c=b(this),d=c.data();d.offset=d.offset||{};d.offsetBottom&&(d.offset.bottom=d.offsetBottom);d.offsetTop&&(d.offset.top=d.offsetTop);c.affix(d)})})}(window.jQuery);!function(c){var a='[data-dismiss="alert"]',b=function(d){c(d).on("click",a,this.close)};b.prototype.close=function(g){var h=c(this),d=h.attr("data-target"),i;if(!d){d=h.attr("href");d=d&&d.replace(/.*(?=#[^\s]*$)/,"")}i=c(d);g&&g.preventDefault();i.length||(i=h.hasClass("alert")?h:h.parent());i.trigger(g=c.Event("close"));if(g.isDefaultPrevented()){return}i.removeClass("in");function f(){i.trigger("closed").remove()}c.support.transition&&i.hasClass("fade")?i.on(c.support.transition.end,f):f()};c.fn.alert=function(d){return this.each(function(){var e=c(this),f=e.data("alert");if(!f){e.data("alert",(f=new b(this)))}if(typeof d=="string"){f[d].call(e)}})};c.fn.alert.Constructor=b;c(document).on("click.alert.data-api",a,b.prototype.close)}(window.jQuery);!function(b){var a=function(c,d){this.$element=b(c);this.options=b.extend({},b.fn.button.defaults,d)};a.prototype.setState=function(c){var f="disabled",e=this.$element,h=e.data(),g=e.is("input")?"val":"html";c=c+"Text";h.resetText||e.data("resetText",e[g]());e[g](h[c]||this.options[c]);setTimeout(function(){c=="loadingText"?e.addClass(f).attr(f,f):e.removeClass(f).removeAttr(f)},0)};a.prototype.toggle=function(){var c=this.$element.closest('[data-toggle="buttons-radio"]');c&&c.find(".active").removeClass("active");this.$element.toggleClass("active")};b.fn.button=function(c){return this.each(function(){var e=b(this),f=e.data("button"),d=typeof c=="object"&&c;if(!f){e.data("button",(f=new a(this,d)))}if(c=="toggle"){f.toggle()}else{if(c){f.setState(c)}}})};b.fn.button.defaults={loadingText:"loading..."};b.fn.button.Constructor=a;b(document).on("click.button.data-api","[data-toggle^=button]",function(c){var d=b(c.target);if(!d.hasClass("btn")){d=d.closest(".btn")}d.button("toggle")})}(window.jQuery);!function(b){var a=function(c,d){this.$element=b(c);this.options=d;this.options.slide&&this.slide(this.options.slide);this.options.pause=="hover"&&this.$element.on("mouseenter",b.proxy(this.pause,this)).on("mouseleave",b.proxy(this.cycle,this))};a.prototype={cycle:function(c){if(!c){this.paused=false}this.options.interval&&!this.paused&&(this.interval=setInterval(b.proxy(this.next,this),this.options.interval));return this},to:function(f){var e=this.$element.find(".item.active"),d=e.parent().children(),g=d.index(e),c=this;if(f>(d.length-1)||f<0){return}if(this.sliding){return this.$element.one("slid",function(){c.to(f)})}if(g==f){return this.pause().cycle()}return this.slide(f>g?"next":"prev",b(d[f]))},pause:function(c){if(!c){this.paused=true}if(this.$element.find(".next, .prev").length&&b.support.transition.end){this.$element.trigger(b.support.transition.end);this.cycle()}clearInterval(this.interval);this.interval=null;return this},next:function(){if(this.sliding){return}return this.slide("next")},prev:function(){if(this.sliding){return}return this.slide("prev")},slide:function(h,d){var i=this.$element.find(".item.active"),g=d||i[h](),k=this.interval,l=h=="next"?"left":"right",c=h=="next"?"first":"last",f=this,j;this.sliding=true;k&&this.pause();g=g.length?g:this.$element.find(".item")[c]();j=b.Event("slide",{relatedTarget:g[0]});if(g.hasClass("active")){return}if(b.support.transition&&this.$element.hasClass("slide")){this.$element.trigger(j);if(j.isDefaultPrevented()){return}g.addClass(h);g[0].offsetWidth;i.addClass(l);g.addClass(l);this.$element.one(b.support.transition.end,function(){g.removeClass([h,l].join(" ")).addClass("active");i.removeClass(["active",l].join(" "));f.sliding=false;setTimeout(function(){f.$element.trigger("slid")},0)})}else{this.$element.trigger(j);if(j.isDefaultPrevented()){return}i.removeClass("active");g.addClass("active");this.sliding=false;this.$element.trigger("slid")}k&&this.cycle();return this}};b.fn.carousel=function(c){return this.each(function(){var f=b(this),g=f.data("carousel"),e=b.extend({},b.fn.carousel.defaults,typeof c=="object"&&c),d=typeof c=="string"?c:e.slide;if(!g){f.data("carousel",(g=new a(this,e)))}if(typeof c=="number"){g.to(c)}else{if(d){g[d]()}else{if(e.interval){g.cycle()}}}})};b.fn.carousel.defaults={interval:5000,pause:"hover"};b.fn.carousel.Constructor=a;b(document).on("click.carousel.data-api","[data-slide]",function(g){var h=b(this),c,d=b(h.attr("data-target")||(c=h.attr("href"))&&c.replace(/.*(?=#[^\s]+$)/,"")),f=b.extend({},d.data(),h.data());d.carousel(f);g.preventDefault()})}(window.jQuery);!function(a){var b=function(c,d){this.$element=a(c);this.options=a.extend({},a.fn.collapse.defaults,d);if(this.options.parent){this.$parent=a(this.options.parent)}this.options.toggle&&this.toggle()};b.prototype={constructor:b,dimension:function(){var c=this.$element.hasClass("width");return c?"width":"height"},show:function(){var c,d,f,e;if(this.transitioning){return}c=this.dimension();d=a.camelCase(["scroll",c].join("-"));f=this.$parent&&this.$parent.find("> .accordion-group > .in");if(f&&f.length){e=f.data("collapse");if(e&&e.transitioning){return}f.collapse("hide");e||f.data("collapse",null)}this.$element[c](0);this.transition("addClass",a.Event("show"),"shown");a.support.transition&&this.$element[c](this.$element[0][d])},hide:function(){var c;if(this.transitioning){return}c=this.dimension();this.reset(this.$element[c]());this.transition("removeClass",a.Event("hide"),"hidden");this.$element[c](0)},reset:function(c){var d=this.dimension();this.$element.removeClass("collapse")[d](c||"auto")[0].offsetWidth;this.$element[c!==null?"addClass":"removeClass"]("collapse");return this},transition:function(d,e,f){var g=this,c=function(){if(e.type=="show"){g.reset()}g.transitioning=0;g.$element.trigger(f)};this.$element.trigger(e);if(e.isDefaultPrevented()){return}this.transitioning=1;this.$element[d]("in");a.support.transition&&this.$element.hasClass("collapse")?this.$element.one(a.support.transition.end,c):c()},toggle:function(){this[this.$element.hasClass("in")?"hide":"show"]()}};a.fn.collapse=function(c){return this.each(function(){var e=a(this),f=e.data("collapse"),d=typeof c=="object"&&c;if(!f){e.data("collapse",(f=new b(this,d)))}if(typeof c=="string"){f[c]()}})};a.fn.collapse.defaults={toggle:true};a.fn.collapse.Constructor=b;a(document).on("click.collapse.data-api","[data-toggle=collapse]",function(g){var h=a(this),c,d=h.attr("data-target")||g.preventDefault()||(c=h.attr("href"))&&c.replace(/.*(?=#[^\s]+$)/,""),f=a(d).data("collapse")?"toggle":h.data();h[a(d).hasClass("in")?"addClass":"removeClass"]("collapsed");a(d).collapse(f)})}(window.jQuery);!function(e){var b="[data-toggle=dropdown]",d=function(g){var f=e(g).on("click.dropdown.data-api",this.toggle);e("html").on("click.dropdown.data-api",function(){f.parent().removeClass("open")})};d.prototype={constructor:d,toggle:function(g){var h=e(this),i,f;if(h.is(".disabled, :disabled")){return}i=a(h);f=i.hasClass("open");c();if(!f){i.toggleClass("open");h.focus()}return false},keydown:function(j){var k,h,i,l,g,f;if(!/(38|40|27)/.test(j.keyCode)){return}k=e(this);j.preventDefault();j.stopPropagation();if(k.is(".disabled, :disabled")){return}l=a(k);g=l.hasClass("open");if(!g||(g&&j.keyCode==27)){return k.click()}h=e("[role=menu] li:not(.divider) a",l);if(!h.length){return}f=h.index(h.filter(":focus"));if(j.keyCode==38&&f>0){f--}if(j.keyCode==40&&f<h.length-1){f++}if(!~f){f=0}h.eq(f).focus()}};function c(){e(b).each(function(){a(e(this)).removeClass("open")})}function a(g){var f=g.attr("data-target"),h;if(!f){f=g.attr("href");f=f&&/#/.test(f)&&f.replace(/.*(?=#[^\s]*$)/,"")}h=e(f);h.length||(h=g.parent());return h}e.fn.dropdown=function(f){return this.each(function(){var g=e(this),h=g.data("dropdown");if(!h){g.data("dropdown",(h=new d(this)))}if(typeof f=="string"){h[f].call(g)}})};e.fn.dropdown.Constructor=d;e(document).on("click.dropdown.data-api touchstart.dropdown.data-api",c).on("click.dropdown touchstart.dropdown.data-api",".dropdown form",function(f){f.stopPropagation()}).on("click.dropdown.data-api touchstart.dropdown.data-api",b,d.prototype.toggle).on("keydown.dropdown.data-api touchstart.dropdown.data-api",b+", [role=menu]",d.prototype.keydown)}(window.jQuery);!function(b){var a=function(c,d){this.options=d;this.$element=b(c).delegate('[data-dismiss="modal"]',"click.dismiss.modal",b.proxy(this.hide,this));this.options.remote&&this.$element.find(".modal-body").load(this.options.remote)};a.prototype={constructor:a,toggle:function(){return this[!this.isShown?"show":"hide"]()},show:function(){var c=this,d=b.Event("show");this.$element.trigger(d);if(this.isShown||d.isDefaultPrevented()){return}this.isShown=true;this.escape();this.backdrop(function(){var e=b.support.transition&&c.$element.hasClass("fade");if(!c.$element.parent().length){c.$element.appendTo(document.body)}c.$element.show();if(e){c.$element[0].offsetWidth}c.$element.addClass("in").attr("aria-hidden",false);c.enforceFocus();e?c.$element.one(b.support.transition.end,function(){c.$element.focus().trigger("shown")}):c.$element.focus().trigger("shown")})},hide:function(d){d&&d.preventDefault();var c=this;d=b.Event("hide");this.$element.trigger(d);if(!this.isShown||d.isDefaultPrevented()){return}this.isShown=false;this.escape();b(document).off("focusin.modal");this.$element.removeClass("in").attr("aria-hidden",true);b.support.transition&&this.$element.hasClass("fade")?this.hideWithTransition():this.hideModal()},enforceFocus:function(){var c=this;b(document).on("focusin.modal",function(d){if(c.$element[0]!==d.target&&!c.$element.has(d.target).length){c.$element.focus()}})},escape:function(){var c=this;if(this.isShown&&this.options.keyboard){this.$element.on("keyup.dismiss.modal",function(d){d.which==27&&c.hide()})}else{if(!this.isShown){this.$element.off("keyup.dismiss.modal")}}},hideWithTransition:function(){var c=this,d=setTimeout(function(){c.$element.off(b.support.transition.end);c.hideModal()},500);this.$element.one(b.support.transition.end,function(){clearTimeout(d);c.hideModal()})},hideModal:function(c){this.$element.hide().trigger("hidden");this.backdrop()},removeBackdrop:function(){this.$backdrop.remove();this.$backdrop=null},backdrop:function(f){var c=this,d=this.$element.hasClass("fade")?"fade":"";if(this.isShown&&this.options.backdrop){var e=b.support.transition&&d;this.$backdrop=b('<div class="modal-backdrop '+d+'" />').appendTo(document.body);this.$backdrop.click(this.options.backdrop=="static"?b.proxy(this.$element[0].focus,this.$element[0]):b.proxy(this.hide,this));if(e){this.$backdrop[0].offsetWidth}this.$backdrop.addClass("in");e?this.$backdrop.one(b.support.transition.end,f):f()}else{if(!this.isShown&&this.$backdrop){this.$backdrop.removeClass("in");b.support.transition&&this.$element.hasClass("fade")?this.$backdrop.one(b.support.transition.end,b.proxy(this.removeBackdrop,this)):this.removeBackdrop()}else{if(f){f()}}}}};b.fn.modal=function(c){return this.each(function(){var e=b(this),f=e.data("modal"),d=b.extend({},b.fn.modal.defaults,e.data(),typeof c=="object"&&c);if(!f){e.data("modal",(f=new a(this,d)))}if(typeof c=="string"){f[c]()}else{if(d.show){f.show()}}})};b.fn.modal.defaults={backdrop:true,keyboard:true,show:true};b.fn.modal.Constructor=a;b(document).on("click.modal.data-api",'[data-toggle="modal"]',function(g){var h=b(this),c=h.attr("href"),d=b(h.attr("data-target")||(c&&c.replace(/.*(?=#[^\s]+$)/,""))),f=d.data("modal")?"toggle":b.extend({remote:!/#/.test(c)&&c},d.data(),h.data());g.preventDefault();d.modal(f).one("hide",function(){h.focus()})})}(window.jQuery);!function(a){var b=function(c,d){this.init("popover",c,d)};b.prototype=a.extend({},a.fn.tooltip.Constructor.prototype,{constructor:b,setContent:function(){var e=this.tip(),c=this.getTitle(),d=this.getContent();e.find(".popover-title")[this.options.html?"html":"text"](c);e.find(".popover-content > *")[this.options.html?"html":"text"](d);e.removeClass("fade top bottom left right in")},hasContent:function(){return this.getTitle()||this.getContent()},getContent:function(){var c,d=this.$element,e=this.options;c=d.attr("data-content")||(typeof e.content=="function"?e.content.call(d[0]):e.content);return c},tip:function(){if(!this.$tip){this.$tip=a(this.options.template)}return this.$tip},destroy:function(){this.hide().$element.off("."+this.type).removeData(this.type)}});a.fn.popover=function(c){return this.each(function(){var e=a(this),f=e.data("popover"),d=typeof c=="object"&&c;if(!f){e.data("popover",(f=new b(this,d)))}if(typeof c=="string"){f[c]()}})};a.fn.popover.Constructor=b;a.fn.popover.defaults=a.extend({},a.fn.tooltip.defaults,{placement:"right",trigger:"click",content:"",template:'<div class="popover"><div class="arrow"></div><div class="popover-inner"><h3 class="popover-title"></h3><div class="popover-content"><p></p></div></div></div>'})}(window.jQuery);!function(a){function b(f,g){var e=a.proxy(this.process,this),d=a(f).is("body")?a(window):a(f),c;this.options=a.extend({},a.fn.scrollspy.defaults,g);this.$scrollElement=d.on("scroll.scroll-spy.data-api",e);this.selector=(this.options.target||((c=a(f).attr("href"))&&c.replace(/.*(?=#[^\s]+$)/,""))||"")+" .nav li > a";this.$body=a("body");this.refresh();this.process()}b.prototype={constructor:b,refresh:function(){var c=this,d;this.offsets=a([]);this.targets=a([]);d=this.$body.find(this.selector).map(function(){var e=a(this),f=e.data("target")||e.attr("href"),g=/^#\w/.test(f)&&a(f);return(g&&g.length&&[[g.position().top,f]])||null}).sort(function(e,f){return e[0]-f[0]}).each(function(){c.offsets.push(this[0]);c.targets.push(this[1])})},process:function(){var h=this.$scrollElement.scrollTop()+this.options.offset,e=this.$scrollElement[0].scrollHeight||this.$body[0].scrollHeight,g=e-this.$scrollElement.height(),j=this.offsets,c=this.targets,f=this.activeTarget,d;if(h>=g){return f!=(d=c.last()[0])&&this.activate(d)}for(d=j.length;d--;){f!=c[d]&&h>=j[d]&&(!j[d+1]||h<=j[d+1])&&this.activate(c[d])}},activate:function(c){var e,d;this.activeTarget=c;a(this.selector).parent(".active").removeClass("active");d=this.selector+'[data-target="'+c+'"],'+this.selector+'[href="'+c+'"]';e=a(d).parent("li").addClass("active");if(e.parent(".dropdown-menu").length){e=e.closest("li.dropdown").addClass("active")}e.trigger("activate")}};a.fn.scrollspy=function(c){return this.each(function(){var e=a(this),f=e.data("scrollspy"),d=typeof c=="object"&&c;if(!f){e.data("scrollspy",(f=new b(this,d)))}if(typeof c=="string"){f[c]()}})};a.fn.scrollspy.Constructor=b;a.fn.scrollspy.defaults={offset:10};a(window).on("load",function(){a('[data-spy="scroll"]').each(function(){var c=a(this);c.scrollspy(c.data())})})}(window.jQuery);!function(b){var a=function(c){this.element=b(c)};a.prototype={constructor:a,show:function(){var i=this.element,c=i.closest("ul:not(.dropdown-menu)"),g=i.attr("data-target"),f,d,h;if(!g){g=i.attr("href");g=g&&g.replace(/.*(?=#[^\s]*$)/,"")}if(i.parent("li").hasClass("active")){return}f=c.find(".active:last a")[0];h=b.Event("show",{relatedTarget:f});i.trigger(h);if(h.isDefaultPrevented()){return}d=b(g);this.activate(i.parent("li"),c);this.activate(d,d.parent(),function(){i.trigger({type:"shown",relatedTarget:f})})},activate:function(f,d,h){var e=d.find("> .active"),c=h&&b.support.transition&&e.hasClass("fade");function g(){e.removeClass("active").find("> .dropdown-menu > .active").removeClass("active");f.addClass("active");if(c){f[0].offsetWidth;f.addClass("in")}else{f.removeClass("fade")}if(f.parent(".dropdown-menu")){f.closest("li.dropdown").addClass("active")}h&&h()}c?e.one(b.support.transition.end,g):g();e.removeClass("in")}};b.fn.tab=function(c){return this.each(function(){var d=b(this),e=d.data("tab");if(!e){d.data("tab",(e=new a(this)))}if(typeof c=="string"){e[c]()}})};b.fn.tab.Constructor=a;b(document).on("click.tab.data-api",'[data-toggle="tab"], [data-toggle="pill"]',function(c){c.preventDefault();b(this).tab("show")})}(window.jQuery);!function(b){var a=function(c,d){this.$element=b(c);this.options=b.extend({},b.fn.typeahead.defaults,d);this.matcher=this.options.matcher||this.matcher;this.sorter=this.options.sorter||this.sorter;this.highlighter=this.options.highlighter||this.highlighter;this.updater=this.options.updater||this.updater;this.$menu=b(this.options.menu).appendTo("body");this.source=this.options.source;this.shown=false;this.listen()};a.prototype={constructor:a,select:function(){var c=this.$menu.find(".active").attr("data-value");this.$element.val(this.updater(c)).change();return this.hide()},updater:function(c){return c},show:function(){var c=b.extend({},this.$element.offset(),{height:this.$element[0].offsetHeight});this.$menu.css({top:c.top+c.height,left:c.left});this.$menu.show();this.shown=true;return this},hide:function(){this.$menu.hide();this.shown=false;return this},lookup:function(c){var d;this.query=this.$element.val();if(!this.query||this.query.length<this.options.minLength){return this.shown?this.hide():this}d=b.isFunction(this.source)?this.source(this.query,b.proxy(this.process,this)):this.source;return d?this.process(d):this},process:function(d){var c=this;d=b.grep(d,function(e){return c.matcher(e)});d=this.sorter(d);if(!d.length){return this.shown?this.hide():this}return this.render(d.slice(0,this.options.items)).show()},matcher:function(c){return ~c.toLowerCase().indexOf(this.query.toLowerCase())},sorter:function(e){var c=[],g=[],f=[],d;while(d=e.shift()){if(!d.toLowerCase().indexOf(this.query.toLowerCase())){c.push(d)}else{if(~d.indexOf(this.query)){g.push(d)}else{f.push(d)}}}return c.concat(g,f)},highlighter:function(d){var c=this.query.replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g,"\\$&");return d.replace(new RegExp("("+c+")","ig"),function(f,e){return"<strong>"+e+"</strong>"})},render:function(d){var c=this;d=b(d).map(function(e,f){e=b(c.options.item).attr("data-value",f);e.find("a").html(c.highlighter(f));return e[0]});d.first().addClass("active");this.$menu.html(d);return this},next:function(c){var d=this.$menu.find(".active").removeClass("active"),e=d.next();if(!e.length){e=b(this.$menu.find("li")[0])}e.addClass("active")},prev:function(d){var e=this.$menu.find(".active").removeClass("active"),c=e.prev();if(!c.length){c=this.$menu.find("li").last()}c.addClass("active")},listen:function(){this.$element.on("blur",b.proxy(this.blur,this)).on("keypress",b.proxy(this.keypress,this)).on("keyup",b.proxy(this.keyup,this));if(this.eventSupported("keydown")){this.$element.on("keydown",b.proxy(this.keydown,this))}this.$menu.on("click",b.proxy(this.click,this)).on("mouseenter","li",b.proxy(this.mouseenter,this))},eventSupported:function(c){var d=c in this.$element;if(!d){this.$element.setAttribute(c,"return;");d=typeof this.$element[c]==="function"}return d},move:function(c){if(!this.shown){return}switch(c.keyCode){case 9:case 13:case 27:c.preventDefault();break;case 38:c.preventDefault();this.prev();break;case 40:c.preventDefault();this.next();break}c.stopPropagation()},keydown:function(c){this.suppressKeyPressRepeat=!~b.inArray(c.keyCode,[40,38,9,13,27]);this.move(c)},keypress:function(c){if(this.suppressKeyPressRepeat){return}this.move(c)},keyup:function(c){switch(c.keyCode){case 40:case 38:case 16:case 17:case 18:break;case 9:case 13:if(!this.shown){return}this.select();break;case 27:if(!this.shown){return}this.hide();break;default:this.lookup()}c.stopPropagation();c.preventDefault()},blur:function(d){var c=this;setTimeout(function(){c.hide()},150)},click:function(c){c.stopPropagation();c.preventDefault();this.select()},mouseenter:function(c){this.$menu.find(".active").removeClass("active");b(c.currentTarget).addClass("active")}};b.fn.typeahead=function(c){return this.each(function(){var e=b(this),f=e.data("typeahead"),d=typeof c=="object"&&c;if(!f){e.data("typeahead",(f=new a(this,d)))}if(typeof c=="string"){f[c]()}})};b.fn.typeahead.defaults={source:[],items:8,menu:'<ul class="typeahead dropdown-menu"></ul>',item:'<li><a href="#"></a></li>',minLength:1};b.fn.typeahead.Constructor=a;b(document).on("focus.typeahead.data-api",'[data-provide="typeahead"]',function(c){var d=b(this);if(d.data("typeahead")){return}c.preventDefault();d.typeahead(d.data())})}(window.jQuery);!function(b){var a=function(c,d){this.init("tooltip",c,d)};a.prototype={constructor:a,init:function(d,e,f){var g,c;this.type=d;this.$element=b(e);this.options=this.getOptions(f);this.enabled=true;if(this.options.trigger=="click"){this.$element.on("click."+this.type,this.options.selector,b.proxy(this.toggle,this))}else{if(this.options.trigger!="manual"){g=this.options.trigger=="hover"?"mouseenter":"focus";c=this.options.trigger=="hover"?"mouseleave":"blur";this.$element.on(g+"."+this.type,this.options.selector,b.proxy(this.enter,this));this.$element.on(c+"."+this.type,this.options.selector,b.proxy(this.leave,this))}}this.options.selector?(this._options=b.extend({},this.options,{trigger:"manual",selector:""})):this.fixTitle()},getOptions:function(c){c=b.extend({},b.fn[this.type].defaults,c,this.$element.data());if(c.delay&&typeof c.delay=="number"){c.delay={show:c.delay,hide:c.delay}}return c},enter:function(d){var c=b(d.currentTarget)[this.type](this._options).data(this.type);if(!c.options.delay||!c.options.delay.show){return c.show()}clearTimeout(this.timeout);c.hoverState="in";this.timeout=setTimeout(function(){if(c.hoverState=="in"){c.show()}},c.options.delay.show)},leave:function(d){var c=b(d.currentTarget)[this.type](this._options).data(this.type);if(this.timeout){clearTimeout(this.timeout)}if(!c.options.delay||!c.options.delay.hide){return c.hide()}c.hoverState="out";this.timeout=setTimeout(function(){if(c.hoverState=="out"){c.hide()}},c.options.delay.hide)},show:function(){var h,e,f,i,c,g,d;if(this.hasContent()&&this.enabled){h=this.tip();this.setContent();if(this.options.animation){h.addClass("fade")}g=typeof this.options.placement=="function"?this.options.placement.call(this,h[0],this.$element[0]):this.options.placement;e=/in/.test(g);h.detach().css({top:0,left:0,display:"block"}).insertAfter(this.$element);f=this.getPosition(e);i=h[0].offsetWidth;c=h[0].offsetHeight;switch(e?g.split(" ")[1]:g){case"bottom":d={top:f.top+f.height,left:f.left+f.width/2-i/2};break;case"top":d={top:f.top-c,left:f.left+f.width/2-i/2};break;case"left":d={top:f.top+f.height/2-c/2,left:f.left-i};break;case"right":d={top:f.top+f.height/2-c/2,left:f.left+f.width};break}h.offset(d).addClass(g).addClass("in")}},setContent:function(){var d=this.tip(),c=this.getTitle();d.find(".tooltip-inner")[this.options.html?"html":"text"](c);d.removeClass("fade in top bottom left right")},hide:function(){var c=this,e=this.tip();e.removeClass("in");function d(){var f=setTimeout(function(){e.off(b.support.transition.end).detach()},500);e.one(b.support.transition.end,function(){clearTimeout(f);e.detach()})}b.support.transition&&this.$tip.hasClass("fade")?d():e.detach();return this},fixTitle:function(){var c=this.$element;if(c.attr("title")||typeof(c.attr("data-original-title"))!="string"){c.attr("data-original-title",c.attr("title")||"").removeAttr("title")}},hasContent:function(){return this.getTitle()},getPosition:function(c){return b.extend({},(c?{top:0,left:0}:this.$element.offset()),{width:this.$element[0].offsetWidth,height:this.$element[0].offsetHeight})},getTitle:function(){var c,d=this.$element,e=this.options;c=d.attr("data-original-title")||(typeof e.title=="function"?e.title.call(d[0]):e.title);return c},tip:function(){return this.$tip=this.$tip||b(this.options.template)},validate:function(){if(!this.$element[0].parentNode){this.hide();this.$element=null;this.options=null}},enable:function(){this.enabled=true},disable:function(){this.enabled=false},toggleEnabled:function(){this.enabled=!this.enabled},toggle:function(d){var c=b(d.currentTarget)[this.type](this._options).data(this.type);c[c.tip().hasClass("in")?"hide":"show"]()},destroy:function(){this.hide().$element.off("."+this.type).removeData(this.type)}};b.fn.tooltip=function(c){return this.each(function(){var e=b(this),f=e.data("tooltip"),d=typeof c=="object"&&c;if(!f){e.data("tooltip",(f=new a(this,d)))}if(typeof c=="string"){f[c]()}})};b.fn.tooltip.Constructor=a;b.fn.tooltip.defaults={animation:true,placement:"top",selector:false,template:'<div class="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>',trigger:"hover",title:"",delay:0,html:false}}(window.jQuery);!function(a){a(function(){a.support.transition=(function(){var b=(function(){var d=document.createElement("bootstrap"),e={WebkitTransition:"webkitTransitionEnd",MozTransition:"transitionend",OTransition:"oTransitionEnd otransitionend",transition:"transitionend"},c;for(c in e){if(d.style[c]!==undefined){return e[c]}}}());return b&&{end:b}})()})}(window.jQuery);
