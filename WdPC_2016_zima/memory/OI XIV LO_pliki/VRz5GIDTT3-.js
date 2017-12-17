if (self.CavalryLogger) { CavalryLogger.start_js(["spnXH"]); }

__d("XAssociateGroupThreadController",["XController"],(function a(b,c,d,e,f,g){f.exports=c("XController").create("\/groups\/messenger\/associate_group_thread\/",{});}),null);
__d("XGroupSideConversationCreateController",["XController"],(function a(b,c,d,e,f,g){f.exports=c("XController").create("\/groups\/side_conversation\/",{post_id:{type:"Int"}});}),null);
__d('MultiChatController',['AsyncRequest','AsyncSignal','ChatOpenTabEventLogger','FantaTabActions','Form','MercuryDispatcher','MercuryIDs','MercuryLocalIDs','MercuryThreadIDMap','MercuryViewer','MercuryServerDispatcher','MercuryThreads','XAssociateGroupThreadController','XGroupSideConversationCreateController'],(function a(b,c,d,e,f,g){var h=c('MercuryDispatcher').get(),i=c('MercuryThreadIDMap').get(),j=c('MercuryThreads').get(),k=c('XGroupSideConversationCreateController').getURIBuilder().getURI().toString(),l=c('XAssociateGroupThreadController').getURIBuilder().getURI().toString();function m(){}Object.assign(m,{subscribe:function o(p,q){p.subscribe('confirm',function(){this.createGroupThreadFromChooserDialog(p,q);}.bind(this));},subscribeFromPost:function o(p,q){p.subscribe('confirm',function(){this.createGroupPostThreadFromChooserDialog(p,q);}.bind(this));},createGroupPostThreadFromChooserDialog:function o(p,q){var r=c('Form').serialize(p.getRoot()),s=JSON.parse(r.profileChooserItems),t=Object.keys(s).filter(function(u){return !!s[u];});m.createThreadForFBIDs(t);new (c('AsyncRequest'))().setURI(k).setData({post_id:q}).send();p.hide();},createGroupThreadFromChooserDialog:function o(p,q){var r=c('Form').serialize(p.getRoot()),s=JSON.parse(r.profileChooserItems),t=[];for(var u in s)if(s[u])t.push(u);var v=m.createThreadForFBIDs(t),w=h.subscribe('update-thread-ids',function(x,y){for(var z in y)if(y[z]==v){var aa=j.getThreadMetaNow(v),ba=i.getServerIDFromClientIDNow(v);if(aa&&!aa.is_canonical&&ba)c('MercuryServerDispatcher').trySend(l,{group_id:q,thread_id:ba});new (c('AsyncSignal'))('/ajax/groups/chat/log',{group_id:q,message_id:z}).send();h.unsubscribe(w);break;}});p.hide();},createThreadForTokens:function o(p){var q=c('MercuryViewer').getID();if(!p.length)return;p=p.filter(function(s){return s!==q;});var r;if(p.length===0){return;}else if(p.length===1){r=c('MercuryIDs').getThreadIDFromParticipantID(p[0]);c('FantaTabActions').openTab(r);c('ChatOpenTabEventLogger').log('ChatTabView',r);}else{r=c('MercuryLocalIDs').generateThreadID();p.unshift(q);j.createNewLocalThread(r,p);c('FantaTabActions').openTab(r);c('ChatOpenTabEventLogger').log('MultiChatController',r);}return r;},createThreadForFBIDs:function o(p){var q=[];for(var r=0;r<p.length;r++)q.push('fbid:'+p[r]);return m.createThreadForTokens(q);}});var n={};n[l]={mode:c('MercuryServerDispatcher').IMMEDIATE};c('MercuryServerDispatcher').registerEndpoints(n);f.exports=m;}),null);
__d('ProfileChooserSelectionRequiredUtils',['Button'],(function a(b,c,d,e,f,g){var h={initButtonDisabler:function i(j,k){function l(){c('Button').setEnabled(k,!!j.getCheckedCount());}j.subscribe('updateCheckableCount',l);l();},initDialogConfirmCheck:function i(j){j.subscribe('confirm',function(k,l){return c('Button').isEnabled(l);});}};f.exports=h;}),null);
__d('SpammyProfileChooser',['CSS','DOM','Event','ProfileChooser'],(function a(b,c,d,e,f,g){var h,i;h=babelHelpers.inherits(j,c('ProfileChooser'));i=h&&h.prototype;j.prototype.initToggle=function(k){'use strict';c('Event').listen(k,'click',function(){this.toggleAll(k.checked);}.bind(this));};j.prototype.toggleAll=function(k){'use strict';var l=this.typeahead.getCore().getValue();if(!l)this.cache[this.activeCache].forEach(function(n){this.setItemValue(n,k);},this);var m=this.listView;c('DOM').scry(m.getRoot(),'li.checkableListItem').forEach(function(n){if(!c('CSS').hasClass(n,'disabledCheckable')){l&&this.setItemValue(c('DOM').find(n,'.checkbox').value,k);m.toggleCheckableItem(n,k);}},this);this.typeahead.getCore().setHiddenValue(JSON.stringify(this.checkedItems));this.updateCheckableCount();};j.listenForSpammyToggle=function(k,l){'use strict';k.initToggle(l);k.subscribe('clickedCheckable',function(m,n){if(l.checked&&!!n&&!n.new_value)l.checked=false;if(!l.checked&&!!n&&!!n.new_value){var o=k.listView,p=true;c('DOM').scry(o.getRoot(),'li.checkableListItem').every(function(q){if(!c('DOM').find(q,'.checkbox').checked)p=false;return p;});l.checked=p;}});};function j(){'use strict';h.apply(this,arguments);}f.exports=j;}),null);