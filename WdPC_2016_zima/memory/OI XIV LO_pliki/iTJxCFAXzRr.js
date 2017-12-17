if (self.CavalryLogger) { CavalryLogger.start_js(["h07w7"]); }

__d("GroupMemberSuggestionConstants",[],(function a(b,c,d,e,f,g){f.exports={suggestedMemberIdPrefix:"suggested_member_"};}),null);
__d("XGroupMemberActionLoggingController",["XController"],(function a(b,c,d,e,f,g){f.exports=c("XController").create("\/groups\/memberaction\/logging\/",{group_id:{type:"Int"},action_type:{type:"Int",required:true},card_id:{type:"String",required:true}});}),null);
__d('GroupHscrollUnit',['cx','Arbiter','AsyncRequest','BaseUnitCarousel','CSS','tidyEvent','XGroupMemberActionLoggingController'],(function a(b,c,d,e,f,g,h){var i,j,k=1,l=2,m=3,n,o;i=babelHelpers.inherits(p,c('BaseUnitCarousel'));j=i&&i.prototype;function p(q){'use strict';j.constructor.call(this,q);c('Arbiter').subscribe('groupshscroll/creationsuggestionxout',this.onXout.bind(this));var r=q.elements.xout_button;if(r)this.addLoggingForXoutButton(r,q.group_id);this.addActionAndLoggingsForButtons(q);}p.prototype.addActionAndLoggingsForButtons=function(q){'use strict';n=q.group_id;o=this.grid.children;for(var r=0;r<o.length;r++){var s=o[r].getElementsByClassName("_4jy1")[0];if(s)c('tidyEvent')([Event.listen(s,'click',this.onActionClicked.bind(this))]);if(r===o.length-1)return;var t=o[r].getElementsByClassName("_45qt")[0];if(t)c('tidyEvent')([Event.listen(t,'click',this.onSkipClicked.bind(this))]);}};p.prototype.logImpressions=function(){'use strict';o=this.grid.children;if(!n)n=this.config.group_id;this.$GroupHscrollUnit1(n,o[this.visibleIndex].id,k);};p.prototype.onSkipClicked=function(){'use strict';this.$GroupHscrollUnit1(n,o[this.visibleIndex].id,l);j.slideLeft.call(this);};p.prototype.onActionClicked=function(){'use strict';this.$GroupHscrollUnit1(n,o[this.visibleIndex].id,m);};p.prototype.updateLargePager=function(){'use strict';c('CSS').removeClass(this.carousel,"_3ub7");this.$GroupHscrollUnit2(true);this.$GroupHscrollUnit2(false);c('CSS').conditionClass(this.carousel,"_3ub8",this.canSlideLeft()&&this.canSlideRight());};p.prototype.hidePagerButton=function(){'use strict';c('CSS').addClass(this.carousel,"_3ub7");};p.prototype.$GroupHscrollUnit2=function(q){'use strict';var r=q?"_3ub9":"_3uba",s=q?"_3ube":"_3ubg";if(q?this.canSlideRight():this.canSlideLeft()){c('CSS').removeClass(this.carousel,s);c('CSS').removeClass(this.carousel,r);}else{c('CSS').addClass(this.carousel,s);setTimeout(function(){c('CSS').addClass(this.carousel,r);}.bind(this),500);}};p.prototype.addLoggingForXoutButton=function(q,r){'use strict';c('tidyEvent')([Event.listen(q,'click',function(){this.$GroupHscrollUnit1(r,'new_user_whole_cards',l);}.bind(this))]);};p.prototype.$GroupHscrollUnit1=function(q,r,s){'use strict';if(!(r&&q))return;var t=c('XGroupMemberActionLoggingController').getURIBuilder().setInt('group_id',q).setInt('action_type',s).setString('card_id',r).getURI();new (c('AsyncRequest'))().setURI(t).send();};f.exports=p;}),null);
__d('GroupDescription',['Arbiter','Event','tidyEvent'],(function a(b,c,d,e,f,g){var h={onDescriptionActionButtonClick:function i(j){c('tidyEvent')(c('Event').listen(j,'click',function(){c('Arbiter').inform('GroupsRHC/expandDescContainer');}));}};f.exports=h;}),null);
__d('GroupViewportTracking',['csx','DataAttributeUtils','DOM','ViewportTracking','Banzai','ge','viewportTrackingBuilder'],(function a(b,c,d,e,f,g,h){'use strict';var i,j;function k(n){return {getAllStories:function o(){var p=c('ge')('pagelet_group_mall');if(p)return c('DOM').scry(p,"._5pat");return [];},getStoryID:function o(p){var q=JSON.parse(c('DataAttributeUtils').getDataFt(p));return q&&q.mf_story_key;},getDataToLog:function o(p){return JSON.parse(c('DataAttributeUtils').getDataFt(p))||{};}};}i=babelHelpers.inherits(l,c('ViewportTracking'));j=i&&i.prototype;l.prototype.sendDataToLog=function(n,o){if(this.useBanzai)c('Banzai').post('group_feed_tracking',o);};l.prototype.cleanup=function(){m.clearSingleton();j.cleanup.call(this);};function l(){i.apply(this,arguments);}var m=c('viewportTrackingBuilder')(function(n){var o=new l(k(n));o.init(n);return o;});m.init=m.factory.bind(m);f.exports=m;}),null);
__d('GroupsDescTagContainer',['cx','Arbiter','CSS','Event','tidyEvent'],(function a(b,c,d,e,f,g,h){function i(j,k,l){'use strict';this.$GroupsDescTagContainer1=j;this.$GroupsDescTagContainer2=k;this.$GroupsDescTagContainer3=l;this.checkAndCollapseContent();c('Arbiter').subscribe('GroupsRHC/expandDescContainer',this.expandContainer.bind(this));}i.prototype.checkAndCollapseContent=function(){'use strict';if(this.$GroupsDescTagContainer1.getBoundingClientRect().height<=this.$GroupsDescTagContainer3)return;c('CSS').addClass(this.$GroupsDescTagContainer1,"__gz");c('CSS').show(this.$GroupsDescTagContainer2);c('tidyEvent')(c('Event').listen(this.$GroupsDescTagContainer2,'click',this.expandContainer.bind(this)));};i.prototype.expandContainer=function(){'use strict';c('CSS').removeClass(this.$GroupsDescTagContainer1,"__gz");c('CSS').hide(this.$GroupsDescTagContainer2);};f.exports=i;}),null);
__d('GroupsMemberCountUpdater',['Arbiter','DOM'],(function a(b,c,d,e,f,g){function h(){}h.subscribeMemberCount=function(i){c('Arbiter').subscribe('GroupsMemberCount/changeText',function(j,k){c('DOM').setContent(i,k);});};h.subscribeNewMemberCount=function(i){c('Arbiter').subscribe('GroupsMemberCount/changeNewMembersText',function(j,k){c('DOM').setContent(i,k);});};f.exports=h;}),null);
__d("XGroupMemberSuggestionXoutAsyncController",["XController"],(function a(b,c,d,e,f,g){f.exports=c("XController").create("\/groups\/membersuggestion\/xout\/",{});}),null);
__d('GroupMemberSuggestionInvitationToggle',['fbt','Arbiter','AsyncRequest','Button','Event','Parent','CSS','DOM','XGroupMemberSuggestionXoutAsyncController'],(function a(b,c,d,e,f,g,h){var i={registerButton:function j(k,l,m,n,o,p,q,r){k.subscribe('change',function(s,t){if(k.isSelected()){var u={};u.source=p;u.group_id=o;u.members=[n];u.message_id=r;u.recommendation_key=q;new (c('AsyncRequest'))('/ajax/groups/members/add_post.php').setData(u).setMethod('POST').setHandler(function(v){var w=v.getPayload();if(w&&w.error_occurred)k.setSelected(false);}).send();}else k.setSelected(true);});c('Event').listen(m,'mouseover',function(s){c('CSS').show(l);});c('Event').listen(m,'mouseout',function(s){c('CSS').hide(l);});c('Event').listen(l,'click',function(s){var t=c('XGroupMemberSuggestionXoutAsyncController').getURIBuilder().getURI(),u={};u.group_id=o;u.invitee_id=n;u.recommendation_key=q;new (c('AsyncRequest'))(t).setData(u).setMethod('POST').send();});}};f.exports=i;}),null);
__d("XGroupMemberSuggestionsUnitXoutAsyncController",["XController"],(function a(b,c,d,e,f,g){f.exports=c("XController").create("\/groups\/suggestionunit\/xout\/",{group_id:{type:"Int"},recommender_id:{type:"String"}});}),null);
__d("XGroupsMemberSuggestionSeeMoreAsyncController",["XController"],(function a(b,c,d,e,f,g){f.exports=c("XController").create("\/groups\/membersuggestion\/seemore\/",{group_id:{type:"Int",required:true},already_suggested_ids:{type:"IntVector",required:true},replace_suggestion_id:{type:"Int"}});}),null);
__d('GroupMemberSuggestionsRhcUnit',['csx','DOM','Arbiter','AsyncRequest','CSS','Event','GroupMemberSuggestionConstants','XGroupsMemberSuggestionSeeMoreAsyncController','XGroupMemberSuggestionsUnitXoutAsyncController'],(function a(b,c,d,e,f,g,h){function i(j,k,l,m,n){'use strict';this.$GroupMemberSuggestionsRhcUnit1=j;this.$GroupMemberSuggestionsRhcUnit2=k;this.$GroupMemberSuggestionsRhcUnit3=l;this.$GroupMemberSuggestionsRhcUnit4=m;this.$GroupMemberSuggestionsRhcUnit5=n;this.$GroupMemberSuggestionsRhcUnit6();this.$GroupMemberSuggestionsRhcUnit7();this.$GroupMemberSuggestionsRhcUnit8();this.$GroupMemberSuggestionsRhcUnit9();this.$GroupMemberSuggestionsRhcUnit10();this.$GroupMemberSuggestionsRhcUnit11();}i.prototype.$GroupMemberSuggestionsRhcUnit6=function(){'use strict';c('Arbiter').subscribe('GroupMemberAdded',function(event,j){this.$GroupMemberSuggestionsRhcUnit12(j);}.bind(this));};i.prototype.$GroupMemberSuggestionsRhcUnit7=function(){'use strict';c('Arbiter').subscribe('GroupPendingMemberAdded',function(event,j){this.$GroupMemberSuggestionsRhcUnit12(j);}.bind(this));};i.prototype.$GroupMemberSuggestionsRhcUnit8=function(){'use strict';c('Arbiter').subscribe('GroupMemberInvited',function(event,j){this.$GroupMemberSuggestionsRhcUnit12(j);}.bind(this));};i.prototype.$GroupMemberSuggestionsRhcUnit9=function(){'use strict';c('Arbiter').subscribe('GroupMemberSuggestionXouted',function(event,j){this.$GroupMemberSuggestionsRhcUnit12(j);}.bind(this));};i.prototype.$GroupMemberSuggestionsRhcUnit10=function(){'use strict';c('Event').listen(this.$GroupMemberSuggestionsRhcUnit3,'click',function(j){c('CSS').hide(this.$GroupMemberSuggestionsRhcUnit1);var k=c('XGroupMemberSuggestionsUnitXoutAsyncController').getURIBuilder().setInt('group_id',this.$GroupMemberSuggestionsRhcUnit4).setString('recommender_id',this.$GroupMemberSuggestionsRhcUnit5).getURI();new (c('AsyncRequest'))(k).send();}.bind(this));};i.prototype.$GroupMemberSuggestionsRhcUnit11=function(){'use strict';c('Event').listen(this.$GroupMemberSuggestionsRhcUnit2,'click',function(j){var k=c('XGroupsMemberSuggestionSeeMoreAsyncController').getURIBuilder().setInt('group_id',this.$GroupMemberSuggestionsRhcUnit4).setIntVector('already_suggested_ids',this.$GroupMemberSuggestionsRhcUnit13()).getURI();new (c('AsyncRequest'))(k).send();}.bind(this));};i.prototype.$GroupMemberSuggestionsRhcUnit12=function(j){'use strict';var k=c('XGroupsMemberSuggestionSeeMoreAsyncController').getURIBuilder().setInt('group_id',this.$GroupMemberSuggestionsRhcUnit4).setIntVector('already_suggested_ids',this.$GroupMemberSuggestionsRhcUnit13()).setInt('replace_suggestion_id',j).getURI();new (c('AsyncRequest'))(k).send();};i.prototype.$GroupMemberSuggestionsRhcUnit13=function(){'use strict';var j=c('DOM').scry(this.$GroupMemberSuggestionsRhcUnit1,"li"),k=[];for(var l=0;l<j.length;l++){var m=j[l].id.substr(c('GroupMemberSuggestionConstants').suggestedMemberIdPrefix.length);if(!isNaN(m))k.push(parseInt(m,10));}return k;};f.exports=i;}),null);
__d('NotificationsSelector',['Parent','submitForm','AsyncRequest','Event'],(function a(b,c,d,e,f,g){function h(j,k,l){k.subscribe('change',function(m,n){l.value=n.value;var o=c('Parent').byTag(j,'form');o&&c('submitForm')(o);});}function i(j,k,l,m,n,o){k.subscribe('change',function(p,q){new (c('AsyncRequest'))().setURI('/ajax/groups/notifications/update.php').setData({setting:q.value,group_id:m}).setMethod('POST').send();});if(n)n.subscribe('hide',function(){if(o)new (c('AsyncRequest'))().setURI(o).setData({group_id:m}).setMethod('POST').send();});c('Event').listen(j,'click',function(){if(n&&n.isShown())n.hide();});}f.exports.bindForm=h;f.exports.updateNotif=i;}),null);
__d("XGroupCreationSuggestionXOutRHCController",["XController"],(function a(b,c,d,e,f,g){f.exports=c("XController").create("\/gysc\/hide_rhc_suggestion\/",{category:{type:"Enum",enumType:1},identifier:{type:"String"}});}),null);
__d('GroupGYSCXoutHandler',['csx','AsyncRequest','Arbiter','CSS','DOM','DOMQuery','Event','XGroupCreationSuggestionXOutRHCController'],(function a(b,c,d,e,f,g,h){var i={onClickXOut:function j(k,l,m,n){c('Event').listen(k,'click',function(){var o=c('XGroupCreationSuggestionXOutRHCController').getURIBuilder().setEnum('category',l).setString('identifier',m).getURI();new (c('AsyncRequest'))().setURI(o).send();var p=c('DOMQuery').find(document,'#'+n+'_ListItem');c('DOM').remove(p);var q=c('DOMQuery').scry(document,"div._39xw");c('Arbiter').inform('groupshscroll/creationsuggestionxout',{});if(q.length===0){var r=c('DOMQuery').findPushSafe(document,'#GroupsRHCGroupCreationSection','#rhc_gysc_hscroll');if(r!==null)c('DOM').remove(r);}});},showHideButton:function j(k,l){c('Event').listen(l,'mouseover',function(){c('CSS').show(k);});c('Event').listen(l,'mouseleave',function(){c('CSS').hide(k);});}};f.exports=i;}),null);
__d("XGroupsRHCSuggestionXoutController",["XController"],(function a(b,c,d,e,f,g){f.exports=c("XController").create("\/groups\/xout_suggested_group\/",{id:{type:"Int",required:true}});}),null);
__d('GroupSuggestionXoutHandler',['csx','AsyncRequest','CSS','DOM','Event','XGroupsRHCSuggestionXoutController'],(function a(b,c,d,e,f,g,h){var i={onclick:function j(k,l,m){c('Event').listen(k,'click',function(){var n=c('XGroupsRHCSuggestionXoutController').getURIBuilder().setInt('id',l).getURI();new (c('AsyncRequest'))().setURI(n).send();var o=c('DOM').find(document,'#'+m);c('DOM').remove(o);var p=c('DOM').scry(document,"div._1spx");if(p.length===0){var q=c('DOM').find(document,'#GroupsRHCSuggestionSection');if(q!==null)c('DOM').remove(q);}});},hide:function j(k,l){c('Event').listen(l,'mouseover',function(){c('CSS').show(k);});c('Event').listen(l,'mouseleave',function(){c('CSS').hide(k);});}};f.exports=i;}),null);
__d('GroupsAddTypeaheadView',['Arbiter','ContextualTypeaheadView'],(function a(b,c,d,e,f,g){var h,i;h=babelHelpers.inherits(j,c('ContextualTypeaheadView'));i=h&&h.prototype;j.prototype.select=function(k){'use strict';var l=this.results[this.index];c('Arbiter').inform('GroupsMemberSuggestion/remove',l.uid);if(l.is_member){this.reset();}else i.select.call(this,k);};function j(){'use strict';h.apply(this,arguments);}f.exports=j;}),null);
__d('GroupsAddMemberTypeaheadView',['csx','cx','fbt','CSS','CurrentUser','DOM','GroupsAddTypeaheadView','ex','getOrCreateDOMID'],(function a(b,c,d,e,f,g,h,i,j){var k,l,m='friends',n='others',o='coworkers';function p(r){var s;switch(r){case m:s=j._("Znajomi");break;case n:s=j._("Inna");break;case o:s=j._("Wsp\u00f3\u0142pracownicy");break;default:throw new Error(c('ex')('The given typeahead result category seems to be untransformed: %s',r));}var t=c('DOM').create('li',{className:"_3cz5",data:r},s);return t;}k=babelHelpers.inherits(q,c('GroupsAddTypeaheadView'));l=k&&k.prototype;q.prototype.getItems=function(){'use strict';return c('DOM').scry(this.content,'li[role="option"]');};q.prototype.buildResults=function(r){'use strict';var s,t=null;if(typeof this.renderer=='function'){s=this.renderer;t=this.renderer.className||'';}else{s=b.TypeaheadRenderers[this.renderer];t=this.renderer;}s=s.bind(this);var u=null,v=r.reduce(function(y,z,aa){var ba=z.node||s(z,aa),ca=z.bootstrapped&&z.type!='email'?m:n;if(c('CurrentUser').isWorkUser())ca=o;z.header=ca;if(ca!==u){var da=p(ca);if(u!==null)c('CSS').addClass(da,"_3cz6");y=y.concat(da);u=ca;}return y.concat(ba);},[]);if(v.length>0){var w=v.filter(function(y){return c('CSS').matchesSelector(y,"._3cz5");});if(w.length==1&&v[0].className==="_3cz5"&&v[0].attributes.data.value===n)v.shift();}var x=c('DOM').create('ul',{className:t,id:'typeahead_list_'+c('getOrCreateDOMID')(this.typeahead?this.typeahead:this.element)},v);x.setAttribute('role','listbox');return x;};q.prototype.render=function(r,s,t){'use strict';var u={friends:[],others:[]};s.reduce(function(v,w){if(w.header===m){v.friends.push(w);}else v.others.push(w);return v;},u);s=u.friends.concat(u.others);return l.render.call(this,r,s,t);};function q(){'use strict';k.apply(this,arguments);}f.exports=q;}),null);
__d('GroupsAddMessage',['CSS','Event','Toggler','TypeaheadSubmitOnSelect'],(function a(b,c,d,e,f,g){var h={showNUX:true,toggleState:function i(j,k,l){j.init();var m=j.getCore();m.reset();k.value='';if(!c('CSS').hasClass(l,'openToggler')){j.disableBehavior(c('TypeaheadSubmitOnSelect'));m.resetOnSelect=false;}else{j.enableBehavior(c('TypeaheadSubmitOnSelect'));m.resetOnSelect=true;}},initEvents:function i(j,k,l,m,n,o,p){c('Event').listen(j,'click',function(){h.toggleState(n,m,p);});c('Event').listen(k,'click',function(){h.toggleState(n,m,p);c('Toggler').toggle(m);c('Toggler').toggle(o);c('Toggler').toggle(k);});c('Event').listen(l,'success',function(){var q=n.getCore();q.reset();});},initNUXEvent:function i(j,k,l){c('Event').listen(j.getCore().getElement(),'select',function(event){if(k&&h.showNUX){k.show();c('Event').kill(event);h.showNUX=false;}});}};f.exports=h;}),null);
__d('GroupsAddMemberTypeahead',['Arbiter','DOM','Typeahead','ge'],(function a(b,c,d,e,f,g){function h(i,j){if(i&&j)this.init(i,j);}Object.assign(h.prototype,{init:function i(j,k){j.subscribe('select',function(l,m){c('Arbiter').inform('GroupsAddMemberTypeahead/add',{gid:k,uid:m.selected.uid,name:m.selected.text,photo:m.selected.photo});});c('Arbiter').subscribe('GroupsAddMemberTypeahead/updateGroupToken',this.resetTypeaheadCaches.bind(this));},resetTypeaheadCaches:function i(j,k){var l=c('DOM').scry(c('ge')('pagelet_group_'),'.uiTypeahead:not(.uiPlacesTypeahead)');for(var m=0;m<l.length;m++){var n=c('Typeahead').getInstance(l[m]);if(n){var o=n.getData();o.updateToken(k.token);n.getCore().subscribe('focus',o.bootstrap.bind(o));}}}});f.exports=h;}),null);
__d('legacy:GroupsAddMemberTypeahead',['GroupsAddMemberTypeahead'],(function a(b,c,d,e,f,g){b.GroupsAddMemberTypeahead=c('GroupsAddMemberTypeahead');}),3);
__d('GroupsAddMemberTypeaheadRenderer',['cx','fbt','DOM'],(function a(b,c,d,e,f,g,h,i){function j(k,l){var m=[];if(k.photo)m.push(c('DOM').create('img',{alt:'',src:k.photo,className:"_2-fx"}));if(k.text)m.push(c('DOM').create('span',{className:"_2-fy"},k.text));if(k.subtext){var n=[k.subtext];m.push(c('DOM').create('span',{className:'subtext'},n));}var o;if(k.type==='member'){o=i._("Jest ju\u017c cz\u0142onkiem");}else if(k.already_invited_to_group){o=i._("Ju\u017c zaproszono");}else o=k.category;m.push(c('DOM').create('span',{className:'subtext'},o));var p=c('DOM').create('li',{className:k.type||''},m);if(k.text){p.setAttribute('title',k.text);p.setAttribute('role','option');p.setAttribute('aria-label',k.text);}return p;}j.className="_2-fz";f.exports=j;}),null);
__d('RequiredFormListener',['Event','Input'],(function a(b,c,d,e,f,g){c('Event').listen(document.documentElement,'submit',function(h){var i=h.getTarget();if(i.getAttribute('novalidate'))return true;var j=i.getElementsByTagName('*');for(var k=0;k<j.length;k++)if(j[k].getAttribute('required')&&c('Input').isEmpty(j[k])){j[k].focus();return false;}},c('Event').Priority.URGENT);}),null);
__d('LitestandRHCAds',['csx','AdsRefreshHandler','Arbiter','DOMQuery','Event','NavigationMessage','Run','SubscriptionsHandler','ge'],(function a(b,c,d,e,f,g,h){var i,j,k,l,m;function n(){j&&j.forceLoadIfEnoughTimePassed(0);}function o(){var t=c('DOMQuery').scry(k,"._5f85 a")[0];if(t)i.addSubscriptions(c('Event').listen(t,'click',n));}function p(){var t=c('ge')(l);if(t&&m){t.appendChild(m);m=null;}}function q(){if(j){j.cleanup();j=null;}if(i){i.release();i=null;}m=null;}function r(t,u){m=u;n();}var s={init:function t(u,v,w){k=c('ge')(u);l=u;j=new (c('AdsRefreshHandler'))(k,v,w).subscribeDefaultEventsForRefresh();i=new (c('SubscriptionsHandler'))();i.addSubscriptions(c('Arbiter').subscribe(c('NavigationMessage').NAVIGATION_BEGIN,q),c('Arbiter').subscribe('AdsRefreshHandler/AdsLoaded',o),c('Arbiter').subscribe('AdsRefreshHandler/AdsLoaded',p),c('Arbiter').subscribe('ProfileQuestionAnswered',r));o();c('Run').onLeave(q);}};f.exports=s;}),null);
__d('GroupAddMemberCustomTypeahead',['Typeahead'],(function a(b,c,d,e,f,g){var h,i;h=babelHelpers.inherits(j,c('Typeahead'));i=h&&h.prototype;function j(k,l,m,n,o){'use strict';i.constructor.call(this,k,l,m,n);this._memberSuggestions=o;}j.prototype.containsInSuggestedMembers=function(k){'use strict';var l=parseInt(k,10);return this._memberSuggestions.indexOf(l)>-1;};j.prototype.addSuggestedMember=function(k){'use strict';var l=parseInt(k,10);this._memberSuggestions.push(l);};j.prototype.removeSuggestedMember=function(k){'use strict';var l=parseInt(k,10),m=this._memberSuggestions.indexOf(l);if(m>-1)this._memberSuggestions.splice(m,1);};f.exports=j;}),null);
__d('PopoverMenuDynamicIcon',['csx','Button','CSS','DOM','DOMQuery'],(function a(b,c,d,e,f,g,h){function i(j){'use strict';this._popoverMenu=j;}i.prototype.enable=function(){'use strict';this._setMenuSubscription=this._popoverMenu.subscribe('setMenu',this._onSetMenu.bind(this));};i.prototype.disable=function(){'use strict';this._popoverMenu.unsubscribe(this._setMenuSubscription);this._setMenuSubscription=null;this._removeChangeSubscription();};i.prototype._onSetMenu=function(){'use strict';this._removeChangeSubscription();this._menu=this._popoverMenu.getMenu();this._changeSubscription=this._menu.subscribe('change',function(j,k){var l=k.item;if(k[0])l=k[0].item;if(!l)return;var m=l.getIcon();m=m?m.cloneNode(true):null;var n=this._popoverMenu.getTriggerElem(),o=c('DOMQuery').scry(n,"span._55pe")[0];if(o){var p=o.firstChild;if(c('CSS').hasClass(p,'img')){c('DOM').replace(p,m);}else c('DOM').prependContent(o,m);}else c('Button').setIcon(n,m);}.bind(this));};i.prototype._removeChangeSubscription=function(){'use strict';if(this._changeSubscription){this._menu.unsubscribe(this._changeSubscription);this._changeSubscription=null;}};Object.assign(i.prototype,{_setMenuSubscription:null,_changeSubscription:null});f.exports=i;}),null);
__d('legacy:SubmitOnSelectTypeaheadBehavior',['TypeaheadSubmitOnSelect'],(function a(b,c,d,e,f,g){if(!b.TypeaheadBehaviors)b.TypeaheadBehaviors={};b.TypeaheadBehaviors.submitOnSelect=function(h){h.enableBehavior(c('TypeaheadSubmitOnSelect'));};}),3);
__d('TypeaheadCustomGroupShowMemberSuggestionsOnFocus',['TypeaheadShowResultsOnFocus'],(function a(b,c,d,e,f,g){var h,i;h=babelHelpers.inherits(j,c('TypeaheadShowResultsOnFocus'));i=h&&h.prototype;j.prototype.enable=function(){'use strict';i.enable.call(this);this.enableCustomizedFeature();};j.prototype.firstFetch=function(k,l,m){'use strict';setTimeout(function(){i.firstFetch.call(this,k,l,m);}.bind(this),200);};j.prototype.enableCustomizedFeature=function(){'use strict';this._typeahead.subscribe('select',function(k,l){this._typeahead.removeSuggestedMember(l.selected.uid);this.refreshAndShowNeededResults(this._typeahead.getCore(),this._typeahead.getData());}.bind(this));};j.prototype.getUidsFromData=function(k){'use strict';var l=k.getAllEntries(),m=[];for(var n in l)if(this._typeahead.containsInSuggestedMembers(l[n].uid))m.push({uid:l[n].uid,index:l[n].index});m.sort(function(o,p){return o.index-p.index;});return m.map(function(o){return o.uid;});};function j(){'use strict';h.apply(this,arguments);}f.exports=j;}),null);
__d('TypeaheadCustomGroupShowMemberSuggestionsOnRHCFocus',['TypeaheadCustomGroupShowMemberSuggestionsOnFocus'],(function a(b,c,d,e,f,g){var h,i;h=babelHelpers.inherits(j,c('TypeaheadCustomGroupShowMemberSuggestionsOnFocus'));i=h&&h.prototype;j.prototype.enableCustomizedFeature=function(){'use strict';this._typeahead.subscribe('select',function(k,l){this._typeahead.removeSuggestedMember(l.selected.uid);}.bind(this));};function j(){'use strict';h.apply(this,arguments);}f.exports=j;}),null);
__d('ToggleButton',['cx','ArbiterMixin','CSS','Event','mixin'],(function a(b,c,d,e,f,g,h){var i,j;i=babelHelpers.inherits(k,c('mixin')(c('ArbiterMixin')));j=i&&i.prototype;function k(l,m){'use strict';j.constructor.call(this);this._root=l;this._selected=m;c('Event').listen(l,'click',this._handleClick.bind(this));}k.prototype.getRoot=function(){'use strict';return this._root;};k.prototype._handleClick=function(){'use strict';var l=!this.isSelected();this.setSelected(l);this.inform(l?'select':'deselect');this.inform('change',{selected:l});return this;};k.prototype.isSelected=function(){'use strict';return this._selected;};k.prototype.setSelected=function(l){'use strict';l=l!==false;if(this._selected!==l){this._selected=l;this._root.setAttribute('aria-pressed',l?'true':'false');c('CSS').conditionClass(this._root,"_42fs",l);}return this;};f.exports=k;}),null);