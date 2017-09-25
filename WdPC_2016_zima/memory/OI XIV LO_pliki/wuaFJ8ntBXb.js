if (self.CavalryLogger) { CavalryLogger.start_js(["cBPZg"]); }

__d("XAYMTPanelSaveSettingsController",["XController"],(function a(b,c,d,e,f,g){f.exports=c("XController").create("\/ads\/growth\/aymt\/homepage_panel\/save_settings\/",{time_range:{type:"Enum",enumType:1},ad_account_id:{type:"Int"},promoted_object:{type:"Int"},collapsed:{type:"Int"},dismiss_nux:{type:"Bool",defaultValue:false},flash_insights_dismiss_nux:{type:"Bool",defaultValue:false},refresh_panel:{type:"Bool",defaultValue:false}});}),null);
__d('AdvertiserHomePagelet',['AsyncRequest','DOM','URI','XAYMTPanelSaveSettingsController','$'],(function a(b,c,d,e,f,g){var h={init:function i(j,k){var l=c('XAYMTPanelSaveSettingsController').getURIBuilder().setBool('refresh_panel',true).getURI();l.addQueryData(c('URI').getRequestURI().getQueryData());new (c('AsyncRequest'))().setURI(l).setStatusElement(k).setErrorHandler(function(m){c('DOM').setContent(c('$')('pagelet_advertiser_panel_content'),'');}).send();}};f.exports=h;}),null);
__d('FeedImageErrorEventLogger',['csx','Arbiter','BanzaiLogger','Bootloader','DataStore','DOMQuery','Event','Parent','Run','ge','getCrossOriginTransport'],(function a(b,c,d,e,f,g,h){'use strict';var i=2,j=false,k=false,l=false,m=0,n=0,o=0,p=0;function q(v){c('BanzaiLogger').log('WebFeedImageErrorEventLoggerConfig',v);}function r(v){return (v&&v.nodeName==='IMG'&&c('Parent').bySelector(v,"._5jmm"));}function s(v){var w;if(r(v.target)){var w=function(){var x,y=v.target,z=y.src;if(l&&!c('DataStore').get(y,'retry')){(function(){o++;c('DataStore').set(y,'retry',true);var aa=c('Event').listen(y,'load',function(){aa.remove();p++;});y.src=z;})();}else{n++;if(m>=i)return {v:void 0};m++;if(k){c('Bootloader').loadModules(["XHRRequest"],function(aa){if(aa)new aa(z).setTransportBuilder(c('getCrossOriginTransport')).setMethod('GET').setResponseHandler(function(){q({error_type:'SUCCESS',src:z});}).setErrorHandler(function(ba){if(ba){var ca=ba.errorMsg;if(ca.indexOf('id="facebook"')>0)ca='FB ERROR PAGE';q({error_code:ba.errorCode,error_type:ba.errorType,error_message:ca,src:z});}}).setTimeoutHandler(function(ba){q({src:ba,error_type:'TIMEOUT'});}).send();},'FeedImageErrorEventLogger');}else q({src:z});}}();if(typeof w==="object")return w.v;}}function t(){if(n>0||o>0){var v=0,w=c('ge')('mainContainer');if(w)v=c('DOMQuery').scry(w,"._5jmm img").length;q({event_name:'IMAGE_LOAD_ERROR_COUNT',error_count:n,retry_attempt_count:o,retry_success_count:p,total_image_count:v});n=0;o=0;p=0;}}var u={init:function v(w){if(j)return;k=w&&w.getDetail;l=w&&w.allowRetries;j=true;window.addEventListener('error',s,true);c('Run').onUnload(function(){return t();});c('Arbiter').subscribe(['pre_page_transition'],function(x,y){return t();});}};f.exports=u;}),null);
__d('ErrorSignal',['AsyncRequest','AsyncSignal','BanzaiODS','ErrorSignalConfig','SessionName','ScriptPath','SiteData','emptyFunction'],(function a(b,c,d,e,f,g){var h=true;function i(m,n){if(m&&m==='beacon_error'){c('BanzaiODS').bumpEntityKey('js_error_reporting','beacon_error_signal.sent');new (c('AsyncSignal'))(c('ErrorSignalConfig').uri,{c:m,m:n}).send();return;}else if(m&&m==='async_error'){var o=JSON.parse(n),p=o.err_code,q=o.path;if(p in {'1004':1,'12029':1,'12031':1,'12152':1}&&q.indexOf('scribe_endpoint.php')==-1){new (c('AsyncRequest'))().setURI(c('ErrorSignalConfig').uri).setData({c:'async_error',m:n}).setMethod('GET').setReadOnly(true).setOption('suppressEvaluation',true).setOption('suppressErrorAlerts',true).setHandler(c('emptyFunction')).setErrorHandler(c('emptyFunction')).send(true);return;}}if(m==='javascript_error')c('BanzaiODS').bumpEntityKey('js_error_reporting','error_signal.sent');new (c('AsyncSignal'))(c('ErrorSignalConfig').uri,{c:m,m:n}).send();}function j(m,n){n=n||{};n.svn_rev=c('SiteData').revision;n.push_phase=c('SiteData').push_phase;n.script_path=c('ScriptPath').getScriptPath();n.extra=n.extra||{};n.extra.hrm=c('SiteData').be_mode;var o=n.extra.type||'error';if(h&&m==='onerror'&&o==='error'){n.extra.extra.push('first_error');h=false;}var p=(c('SessionName').getName()||'-')+'/-';i('javascript_error',JSON.stringify({c:m,a:p,m:n}));}function k(){var m='beacon_error',n=(c('SessionName').getName()||'-')+'/-',o={};o.error=m;o.svn_rev=c('SiteData').revision;o.push_phase=c('SiteData').push_phase;o.script_path=c('ScriptPath').getScriptPath();o.extra={message:m,type:'info'};i(m,JSON.stringify({c:m,a:n,m:o}));}var l={sendBeaconErrorSignal:k,sendErrorSignal:i,logJSError:j};f.exports=l;b.ErrorSignal=l;}),null);
__d('FeedLoadEventWWWLogger',['Arbiter','BanzaiLogger','ErrorSignal','ErrorUtils','LitestandMessages','PageletEventConstsJS','URI'],(function a(b,c,d,e,f,g){var h=['substream_','more_pager_pagelet_','pagelet_composer','pagelet_navigation','pagelet_rhc_footer'],i=[c('PageletEventConstsJS').ARRIVE_END,c('PageletEventConstsJS').DISPLAY_END,c('PageletEventConstsJS').ONLOAD_END],j=['pre_page_transition','page_transition'],k=[c('LitestandMessages').NEWSFEED_LOAD,c('LitestandMessages').STORIES_REQUESTED,c('LitestandMessages').STORIES_INSERTED,c('LitestandMessages').NEWER_STORIES_REQUESTED,c('LitestandMessages').NEWER_STORIES_INSERTED,c('LitestandMessages').STREAM_LOAD_ERROR,c('LitestandMessages').STREAM_LOAD_RETRY,c('LitestandMessages').DUPLICATE_CURSOR_ERROR],l=false;function m(q){return q&&(q.getPath()==='/'||q.getPath()==='/home.php');}function n(q){c('BanzaiLogger').log('WebFeedLoadLoggerConfig',q);}function o(q){if(!q)return null;if(q.indexOf('more_pager_pagelet_')===0)return 'more_pager_pagelet_n';if(q.indexOf('substream_')===0&&q!=='substream_0'&&q!=='substream_1')return 'substream_n';return q;}var p={init:function q(){if(l)return;c('Arbiter').subscribe('BigPipe/init',function(r,s){if(!s||!s.arbiter)return;s.arbiter.subscribe('pagelet_event',function(t,u){if(u&&i.indexOf(u.event)>=0&&h.some(function(v){return u.id.indexOf(v)===0;})&&m(c('URI').getNextURI()))n({event:'pagelet',pagelet_id:o(u.id),pagelet_event_type:u.event,pagelet_phase:u.phase.toString()});});});c('Arbiter').subscribe(j,function(r,s){if(s){var t=s.to||s.uri;if(m(t))n({event:'page_transition',transition_event_type:r});}});c('Arbiter').subscribe(k,function(r,s){var t=null,u=null;if(r===c('LitestandMessages').STREAM_LOAD_ERROR){t=s;}else if(r===c('LitestandMessages').DUPLICATE_CURSOR_ERROR)u=s;n({event:'stream_load',stream_event_type:r,stream_cursor:u,stream_substream_id:o(s&&s.substream_id),error_name:t&&t.name,error_message:t&&t.message,error_stack:t&&t.stack});});c('ErrorUtils').addListener(function(r){if(r&&m(c('URI').getNextURI())){c('ErrorSignal').logJSError('feedloaderror',{error:r.name||r.message,extra:r});n({event:'js_error',error_name:r.name,error_message:r.message,error_stack:r.stack});}});l=true;}};f.exports=p;}),null);
__d('FeedComposerIDStore',['ReactComposerEvents','Arbiter','SubscriptionsHandler'],(function a(b,c,d,e,f,g){'use strict';var h={_composerID:null,_subscriptions:c('SubscriptionsHandler'),set:function i(j){this._subscriptions=new (c('SubscriptionsHandler'))();this._composerID=j;this._subscribeComposerResetEvent();},get:function i(){if(!this._composerID)throw new Error('ID Store has not yet been initialized via set()');return this._composerID;},_subscribeComposerResetEvent:function i(){if(!this._composerID)throw new Error('Composer ID cannot be null');var j=c('Arbiter').subscribeOnce(c('ReactComposerEvents').COMPOSER_RESET+this._composerID,function(k,l){if(l&&l.newComposerID){this._composerID=l.newComposerID;this._subscribeComposerResetEvent();}}.bind(this));this._subscriptions.addSubscriptions(j);}};f.exports=h;}),null);
__d('ReactComposerDraftTypes',[],(function a(b,c,d,e,f,g){var h={NONE:'none',AUTO:'auto',AUTOMSG:'automsg'};f.exports=h;}),null);
__d("XReactFeedComposerXBootloadController",["XController"],(function a(b,c,d,e,f,g){f.exports=c("XController").create("\/react_composer\/feedx\/bootload\/",{composer_id:{type:"String",required:true},composer_type:{type:"Enum",required:true,enumType:1},friend_list_id:{type:"String"},section_id:{type:"String"},target_id:{type:"String",required:true}});}),null);
__d('ReactFeedComposerX',['csx','cx','fbt','invariant','ReactComposerAttachmentType','ReactComposerDraftTypes','ReactComposerEvents','ReactComposerFocusInit','ReactComposerLoggingName','ReactComposerLoggingActions','Arbiter','AsyncRequest','Bootloader','ComposerEntryPointRef','CSS','DOM','Event','FeedComposerIDStore','Run','SubscriptionsHandler','XReactComposerLoggingODSController','XReactFeedComposerXBootloadController','$','requestAnimationFrame'],(function a(b,c,d,e,f,g,h,i,j,k){'use strict';function l(m){this.$ReactFeedComposerX1=m.actorID;this.$ReactFeedComposerX8=m.root;this.$ReactFeedComposerX3=m.composerID;this.$ReactFeedComposerX12=m.targetID;this.$ReactFeedComposerX4=m.composerType;this.$ReactFeedComposerX6=m.friendListID;this.$ReactFeedComposerX9=m.sectionID;this.$ReactFeedComposerX7=m.gks;this.$ReactFeedComposerX14=m.largeTextThreshold;this.$ReactFeedComposerX2=false;this.$ReactFeedComposerX5=c('DOM').find(this.$ReactFeedComposerX8,'form');this.$ReactFeedComposerX13=c('DOM').find(this.$ReactFeedComposerX8,"._3en1");this.$ReactFeedComposerX11=new (c('SubscriptionsHandler'))();this.$ReactFeedComposerX11.addSubscriptions(c('Event').listen(this.$ReactFeedComposerX8,'click',this.$ReactFeedComposerX15.bind(this)),c('Event').listen(this.$ReactFeedComposerX13,'focus',this.$ReactFeedComposerX15.bind(this)),c('Event').listen(this.$ReactFeedComposerX5,'success',this.$ReactFeedComposerX16.bind(this)),c('Arbiter').subscribeOnce('ReactFeedComposerXBootloader/bootload/'+this.$ReactFeedComposerX3,this.$ReactFeedComposerX17.bind(this)),c('Arbiter').subscribeOnce('ReactFeedComposerXBootloader/selectcomposer/'+this.$ReactFeedComposerX3,this.$ReactFeedComposerX15.bind(this)),c('Arbiter').subscribe('ReactComposerFocus/reset/'+this.$ReactFeedComposerX3,function(){this.$ReactFeedComposerX13.value='';}.bind(this)),c('Arbiter').subscribe(c('ReactComposerEvents').TEXT_PREFILL_BEFORE_BOOTLOAD+this.$ReactFeedComposerX3,function(p,q){this.$ReactFeedComposerX13.value=q;this.$ReactFeedComposerX13.selectionEnd=0;}.bind(this)));this.$ReactFeedComposerX11.addSubscriptions(c('Event').listen(this.$ReactFeedComposerX13,'keydown',this.$ReactFeedComposerX18.bind(this)));if(this.$ReactFeedComposerX7&&!this.$ReactFeedComposerX7.shouldRedirectOnClickingProfilePic)this.$ReactFeedComposerX11.addSubscriptions(c('Arbiter').subscribe(c('ReactComposerEvents').ACTIVATE_ATTACHMENT+this.$ReactFeedComposerX3,function(){this.$ReactFeedComposerX13.focus();}.bind(this)));if(this.$ReactFeedComposerX7&&(this.$ReactFeedComposerX7.draftType===c('ReactComposerDraftTypes').AUTO||this.$ReactFeedComposerX7.draftType===c('ReactComposerDraftTypes').AUTOMSG))c('Bootloader').loadModules(["ReactComposerDraftGet"],function(p){var q=p.getDraft(this.$ReactFeedComposerX1);if(q){var r=q.prefillConfig.mentionsInput.textWithEntities.text;if(r.length>this.$ReactFeedComposerX14)c('CSS').removeClass(this.$ReactFeedComposerX13,"_480e");this.$ReactFeedComposerX13.value=r;this.$ReactFeedComposerX13.placeholder=j._("Kontynuuj tworzenia posta...");}}.bind(this),'ReactFeedComposerX');c('FeedComposerIDStore').set(this.$ReactFeedComposerX3);var n=c('DOM').find(this.$ReactFeedComposerX8,"._4d6h"),o=c('DOM').scry(n,'input[name="composer_photo[]"]')[0];if(o){this.$ReactFeedComposerX11.addSubscriptions(c('Event').listen(o,'click',this.$ReactFeedComposerX15.bind(this)),c('Event').listen(o,'change',this.$ReactFeedComposerX15.bind(this)));if(o.files&&o.files.length>0)this.$ReactFeedComposerX15();}this.$ReactFeedComposerX10=c('DOM').scry(this.$ReactFeedComposerX8,"._4-h7");this.$ReactFeedComposerX10.forEach(function(p){return this.$ReactFeedComposerX11.addSubscriptions(c('Event').listen(p,'click',this.$ReactFeedComposerX19.bind(this)));}.bind(this));if(m.jsModules&&m.jsModules.composerFocus&&m.gks&&m.gks.focusExperiment)c('ReactComposerFocusInit').handler(c('$')('feedx_container'),this.$ReactFeedComposerX3,this.$ReactFeedComposerX1,this.$ReactFeedComposerX7,m.jsModules.composerFocus);c('Run').onLeave(this.$ReactFeedComposerX17.bind(this));}l.prototype.$ReactFeedComposerX18=function(m){if(this.$ReactFeedComposerX13.value.length<this.$ReactFeedComposerX14){c('CSS').addClass(this.$ReactFeedComposerX13,"_480e");}else c('CSS').removeClass(this.$ReactFeedComposerX13,"_480e");};l.prototype.$ReactFeedComposerX19=function(m){var n=m.getTarget(),o=null;while(n){if(n.nodeType===1&&n.nodeName==='A'){o=n;break;}n=n.parentNode;}o!==null||k(0);this.$ReactFeedComposerX20(o);var p=c('CSS').hasClass(o,"._5qtn");if(p)return;this.$ReactFeedComposerX10.forEach(function(s){return c('CSS').removeClass(s,"_5qtn");});c('CSS').addClass(o,"_5qtn");var q=c('DOM').find(this.$ReactFeedComposerX8,"._559p"),r=c('DOM').find(this.$ReactFeedComposerX8,"._559q");switch(o.getAttribute('data-attachment-type')){case c('ReactComposerAttachmentType').STATUS:c('CSS').hide(r);c('CSS').show(q);break;case c('ReactComposerAttachmentType').MEDIA:case c('ReactComposerAttachmentType').QANDA:case c('ReactComposerAttachmentType').LIVE_VIDEO:c('CSS').show(r);c('CSS').hide(q);break;}};l.prototype.$ReactFeedComposerX15=function(m){if(this.$ReactFeedComposerX2)return;if(this.$ReactFeedComposerX7&&!this.$ReactFeedComposerX7.shouldRedirectOnClickingProfilePic)c('Arbiter').inform(c('ReactComposerEvents').ACTIVATE_ATTACHMENT+this.$ReactFeedComposerX3);this.$ReactFeedComposerX2=true;this.$ReactFeedComposerX21();var n=c('XReactFeedComposerXBootloadController').getURIBuilder().setString('composer_id',this.$ReactFeedComposerX3).setString('target_id',this.$ReactFeedComposerX12).setEnum('composer_type',this.$ReactFeedComposerX4).setString('friend_list_id',this.$ReactFeedComposerX6).setString('section_id',this.$ReactFeedComposerX9).getURI();new (c('AsyncRequest'))(n).send();var o=c('XReactComposerLoggingODSController').getURIBuilder().setString('event','bootload_start').setEnum('composer_type',c('ComposerEntryPointRef').FEEDX).getURI();new (c('AsyncRequest'))(o).send();};l.prototype.$ReactFeedComposerX20=function(m){var n=c('ReactComposerLoggingName').INLINE_COMPOSER;switch(m.getAttribute('data-attachment-type')){case c('ReactComposerAttachmentType').STATUS:n=c('ReactComposerLoggingName').STATUS_TAB_SELECTOR;break;case c('ReactComposerAttachmentType').MEDIA:n=c('ReactComposerLoggingName').MEDIA_TAB_SELECTOR;break;case c('ReactComposerAttachmentType').LIVE_VIDEO:n=c('ReactComposerLoggingName').LIVE_VIDEO_TAB_SELECTOR;break;case c('ReactComposerAttachmentType').ALBUM:n=c('ReactComposerLoggingName').ALBUM_TAB_SELECTOR;break;case c('ReactComposerAttachmentType').NOTES:n=c('ReactComposerLoggingName').NOTES_TAB_SELECTOR;break;case c('ReactComposerAttachmentType').QANDA:n=c('ReactComposerLoggingName').QANDA_TAB_SELECTOR;break;}c('ReactComposerLoggingActions').composerEntry(this.$ReactFeedComposerX3,n);};l.prototype.$ReactFeedComposerX21=function(){c('ReactComposerLoggingActions').composerEntry(this.$ReactFeedComposerX3,c('ReactComposerLoggingName').INLINE_COMPOSER);};l.prototype.$ReactFeedComposerX17=function(){this.$ReactFeedComposerX11.release();};l.prototype.$ReactFeedComposerX16=function(){this.$ReactFeedComposerX13.value='';c('Arbiter').inform(c('ReactComposerEvents').POST_SUCCEEDED+this.$ReactFeedComposerX3);this.$ReactFeedComposerX17();};f.exports=l;}),null);
__d('ReactComposerFocusScrollLockUtils',['csx','cx','CSS','DOMQuery','ModalLayer','Style','getDocumentScrollElement','getElementRect','getUnboundedScrollPosition','getViewportDimensions','requestAnimationFrame','setTimeoutAcrossTransitions'],(function a(b,c,d,e,f,g,h,i){'use strict';var j=300,k=400,l=84,m={_interval:0,_pageRoot:null,_hasStickyComposer:false,_originalScrollPos:0,enable:function n(o,p){var q=c('getUnboundedScrollPosition')(c('getDocumentScrollElement')());if(c('CSS').matchesSelector(this._getPageRoot(),"._ihc"))return;c('CSS').addClass(this._getPageRoot(),"_ihc");c('ModalLayer').setPageRootAdjusted(true);this._hasStickyComposer=p;if(p){this._originalScrollPos=q.y;var r=Math.min(-this._originalScrollPos+l,0);c('Style').set(this._getPageRoot(),'margin-top',r+'px');}var s=c('getElementRect')(o),t=s.top,u=function(){var v=t+o.offsetHeight+k,w=Math.max(c('getViewportDimensions')().height,v)+this._originalScrollPos+'px';if(c('Style').get(this._getPageRoot(),'height')!==w)c('Style').set(this._getPageRoot(),'height',w);}.bind(this);this._interval=setInterval(u,j);u();c('requestAnimationFrame')(function(){window.scrollTo(q.x,0);});},disable:function n(){var o,p=this;c('CSS').removeClass(this._getPageRoot(),"_ihc");c('ModalLayer').setPageRootAdjusted(false);c('Style').set(this._getPageRoot(),'height',null);if(this._hasStickyComposer)(function(){var q=c('getUnboundedScrollPosition')(c('getDocumentScrollElement')());c('setTimeoutAcrossTransitions')(function(){c('Style').set(this._getPageRoot(),'margin-top',null);window.scrollTo(q.x,this._originalScrollPos);}.bind(p),450);})();clearInterval(this._interval);},_getPageRoot:function n(){if(!this._pageRoot)this._pageRoot=c('DOMQuery').scry(document.body,"._li")[0];return this._pageRoot;}};f.exports=m;}),null);
__d('ReactComposerFocusModal.react',['fbt','ReactComposerDraftTypes','ReactComposerFocusScrollLockUtils','ReactComposerFocusWrapperCore.react','ReactComposerLoggingActions','Arbiter','Bootloader','React','ReactDOM'],(function a(b,c,d,e,f,g,h){var i,j,k=c('React').PropTypes,l=null,m=null,n=null;i=babelHelpers.inherits(o,c('React').PureComponent);j=i&&i.prototype;function o(){var p,q;'use strict';for(var r=arguments.length,s=Array(r),t=0;t<r;t++)s[t]=arguments[t];return q=(p=j.constructor).call.apply(p,[this].concat(s)),this.state={focused:false,showDiscardDialog:false},this.$ReactComposerFocusModal2=function(){if(this.props.gks.draftType==c('ReactComposerDraftTypes').AUTO||this.props.gks.draftType==c('ReactComposerDraftTypes').AUTOMSG){c('Bootloader').loadModules(["ReactComposerHandleUnsavedChanges","ReactComposerFocusSaveAsDraftDialog.react","ReactComposerInit"],function(u,v,w){n=u;m=v;l=w;},'ReactComposerFocusModal.react');}else c('Bootloader').loadModules(["ReactComposerHandleUnsavedChanges","ReactComposerFocusDiscardDialog.react","ReactComposerInit"],function(u,v,w){n=u;m=v;l=w;},'ReactComposerFocusModal.react');}.bind(this),this.$ReactComposerFocusModal4=function(u){if(u)return this.$ReactComposerFocusModal1();if(m&&n&&n.hasUnsavedChanges(this.$ReactComposerFocusModal6())){this.$ReactComposerFocusModal7();}else this.$ReactComposerFocusModal8();}.bind(this),this.$ReactComposerFocusModal8=function(){c('ReactComposerLoggingActions').composerCancel(this.$ReactComposerFocusModal6());this.$ReactComposerFocusModal9();try{if(l)l.resetComposer(this.$ReactComposerFocusModal6());}catch(u){}c('Arbiter').inform('ReactComposerFocus/reset/'+this.$ReactComposerFocusModal6());this.$ReactComposerFocusModal1();}.bind(this),this.$ReactComposerFocusModal3=function(){var u=c('ReactDOM').findDOMNode(this.refs.focus.getComposer());c('ReactComposerFocusScrollLockUtils').enable(u,this.props.gks.hasStickyComposer);this.setState({focused:true});}.bind(this),this.$ReactComposerFocusModal1=function(){c('ReactComposerFocusScrollLockUtils').disable();this.setState({focused:false});}.bind(this),this.$ReactComposerFocusModal7=function(){this.setState({showDiscardDialog:true});}.bind(this),this.$ReactComposerFocusModal9=function(){this.setState({showDiscardDialog:false});}.bind(this),this.$ReactComposerFocusModal6=function(){return this.refs.focus.getComposerID();}.bind(this),q;}o.prototype.componentWillUnmount=function(){'use strict';this.$ReactComposerFocusModal1();};o.prototype.render=function(){'use strict';return c('React').createElement('div',null,c('React').createElement(c('ReactComposerFocusWrapperCore.react'),{composerID:this.props.composerID,ariaLabel:h._("Utw\u00f3rz post"),focused:this.state.focused,fixHeight:true,onFirstFocus:this.$ReactComposerFocusModal2,onFocus:this.$ReactComposerFocusModal3,onDismiss:this.$ReactComposerFocusModal4,gks:this.props.gks,ref:'focus'},this.props.children),this.$ReactComposerFocusModal5());};o.prototype.$ReactComposerFocusModal5=function(){'use strict';var p=null;if(this.state.showDiscardDialog&&m)if(this.props.gks.draftType==c('ReactComposerDraftTypes').AUTO||this.props.gks.draftType==c('ReactComposerDraftTypes').AUTOMSG){p=c('React').createElement(m,{getComposerID:this.$ReactComposerFocusModal6,actorID:this.props.actorID,gks:this.props.gks,onResetComposer:this.$ReactComposerFocusModal8,onCancel:this.$ReactComposerFocusModal9});}else p=c('React').createElement(m,{onConfirm:this.$ReactComposerFocusModal8,onCancel:this.$ReactComposerFocusModal9});return p;};o.propTypes={composerID:k.string.isRequired,actorID:k.string.isRequired,gks:k.object.isRequired};f.exports=o;}),null);
__d("XReactFeedSproutsComposerXBootloadController",["XController"],(function a(b,c,d,e,f,g){f.exports=c("XController").create("\/react_composer\/feedx_sprouts\/bootload\/",{composer_id:{type:"String",required:true},composer_type:{type:"Enum",required:true,enumType:1},friend_list_id:{type:"String"},target_id:{type:"String",required:true}});}),null);
__d('ReactFeedSproutsComposerX',['cx','csx','fbt','invariant','ReactComposerAttachmentType','ReactComposerDraftTypes','ReactComposerEvents','ReactComposerFocusInit','ReactComposerFocusModal.react','Arbiter','AsyncRequest','Bootloader','CSS','DOM','Event','FeedComposerIDStore','Run','SubscriptionsHandler','XReactFeedSproutsComposerXBootloadController','$'],(function a(b,c,d,e,f,g,h,i,j,k){'use strict';function l(m){this.$ReactFeedSproutsComposerX1=m.actorID;this.$ReactFeedSproutsComposerX9=m.root;this.$ReactFeedSproutsComposerX3=m.composerID;this.$ReactFeedSproutsComposerX13=m.targetID;this.$ReactFeedSproutsComposerX4=m.composerType;this.$ReactFeedSproutsComposerX6=m.friendListID;this.$ReactFeedSproutsComposerX7=m.largeTextThreshold;this.$ReactFeedSproutsComposerX8=m.gks;this.$ReactFeedSproutsComposerX2=false;this.$ReactFeedSproutsComposerX5=c('DOM').find(this.$ReactFeedSproutsComposerX9,'form');this.$ReactFeedSproutsComposerX14=c('DOM').find(this.$ReactFeedSproutsComposerX9,"._3en1");this.$ReactFeedSproutsComposerX11=c('DOM').find(this.$ReactFeedSproutsComposerX9,"._16ve");c('FeedComposerIDStore').set(this.$ReactFeedSproutsComposerX3);this.$ReactFeedSproutsComposerX12=new (c('SubscriptionsHandler'))();this.$ReactFeedSproutsComposerX12.addSubscriptions(c('Event').listen(this.$ReactFeedSproutsComposerX14,'focus',this.$ReactFeedSproutsComposerX15.bind(this)),c('Event').listen(this.$ReactFeedSproutsComposerX9,'click',this.$ReactFeedSproutsComposerX15.bind(this)),c('Event').listen(this.$ReactFeedSproutsComposerX5,'success',this.$ReactFeedSproutsComposerX16.bind(this)),c('Arbiter').subscribeOnce('ReactFeedComposerXBootloader/bootload/'+this.$ReactFeedSproutsComposerX3,this.$ReactFeedSproutsComposerX17.bind(this)),c('Arbiter').subscribeOnce('ReactFeedComposerXBootloader/selectcomposer/'+this.$ReactFeedSproutsComposerX3,this.$ReactFeedSproutsComposerX15.bind(this)),c('Arbiter').subscribe('ReactComposerFocus/reset/'+this.$ReactFeedSproutsComposerX3,this.$ReactFeedSproutsComposerX18.bind(this)),c('Arbiter').subscribe(c('ReactComposerEvents').TEXT_PREFILL_BEFORE_BOOTLOAD+this.$ReactFeedSproutsComposerX3,function(o,p){this.$ReactFeedSproutsComposerX14.value=p;this.$ReactFeedSproutsComposerX14.selectionEnd=0;}.bind(this)));if(this.$ReactFeedSproutsComposerX8&&(this.$ReactFeedSproutsComposerX8.draftType===c('ReactComposerDraftTypes').AUTO||this.$ReactFeedSproutsComposerX8.draftType===c('ReactComposerDraftTypes').AUTOMSG))c('Bootloader').loadModules(["ReactComposerDraftGet"],function(o){var p=o.getDraft(this.$ReactFeedSproutsComposerX1);if(p){var q=p.prefillConfig.mentionsInput.textWithEntities.text;if(q.length>this.$ReactFeedSproutsComposerX7)c('CSS').removeClass(this.$ReactFeedSproutsComposerX14,"_480e");this.$ReactFeedSproutsComposerX14.value=q;this.$ReactFeedSproutsComposerX14.placeholder=j._("Kontynuuj tworzenia posta...");}}.bind(this),'ReactFeedSproutsComposerX');this.$ReactFeedSproutsComposerX10=c('DOM').scry(this.$ReactFeedSproutsComposerX9,"._4-h7");this.$ReactFeedSproutsComposerX10.forEach(function(o){return this.$ReactFeedSproutsComposerX12.addSubscriptions(c('Event').listen(o,'click',this.$ReactFeedSproutsComposerX19.bind(this)));}.bind(this));var n=c('DOM').scry(this.$ReactFeedSproutsComposerX9,"._2mo4");if(n.length===1)this.$ReactFeedSproutsComposerX12.addSubscriptions(c('Event').listen(n[0],'click',function(){return c('Bootloader').loadModules(["ReactComposerLiveVideoActions"],function(o){return (o.showDialogComposer(this.$ReactFeedSproutsComposerX3));}.bind(this),'ReactFeedSproutsComposerX');}.bind(this)));c('ReactComposerFocusInit').handler(c('$')('feedx_sprouts_container'),this.$ReactFeedSproutsComposerX3,this.$ReactFeedSproutsComposerX1,this.$ReactFeedSproutsComposerX8,c('ReactComposerFocusModal.react'));c('Run').onLeave(this.$ReactFeedSproutsComposerX17.bind(this));}l.prototype.$ReactFeedSproutsComposerX19=function(m){var n=m.getTarget(),o=null;while(n){if(n.nodeType===1&&n.nodeName==='A'){o=n;break;}n=n.parentNode;}o!==null||k(0);var p=c('CSS').hasClass(o,"._5qtn");if(p)return;this.$ReactFeedSproutsComposerX10.forEach(function(s){return c('CSS').removeClass(s,"_5qtn");});c('CSS').addClass(o,"_5qtn");var q=c('DOM').find(this.$ReactFeedSproutsComposerX9,"._559p"),r=c('DOM').find(this.$ReactFeedSproutsComposerX9,"._559q");switch(o.getAttribute('data-attachment-type')){case c('ReactComposerAttachmentType').STATUS:c('CSS').hide(r);c('CSS').show(q);break;case c('ReactComposerAttachmentType').MEDIA:case c('ReactComposerAttachmentType').LIVE_VIDEO:c('CSS').show(r);c('CSS').hide(q);break;}};l.prototype.$ReactFeedSproutsComposerX15=function(m){this.$ReactFeedSproutsComposerX20();if(this.$ReactFeedSproutsComposerX2)return;this.$ReactFeedSproutsComposerX2=true;var n=c('XReactFeedSproutsComposerXBootloadController').getURIBuilder().setString('composer_id',this.$ReactFeedSproutsComposerX3).setString('target_id',this.$ReactFeedSproutsComposerX13).setEnum('composer_type',this.$ReactFeedSproutsComposerX4).setString('friend_list_id',this.$ReactFeedSproutsComposerX6).getURI();new (c('AsyncRequest'))(n).send();};l.prototype.$ReactFeedSproutsComposerX20=function(){c('CSS').addClass(this.$ReactFeedSproutsComposerX9,"_4qr4");c('CSS').removeClass(this.$ReactFeedSproutsComposerX9,"_4a8c");};l.prototype.$ReactFeedSproutsComposerX21=function(){c('CSS').removeClass(this.$ReactFeedSproutsComposerX9,"_4qr4");c('CSS').addClass(this.$ReactFeedSproutsComposerX9,"_4a8c");};l.prototype.$ReactFeedSproutsComposerX18=function(){this.$ReactFeedSproutsComposerX21();this.$ReactFeedSproutsComposerX14.value='';};l.prototype.$ReactFeedSproutsComposerX17=function(){this.$ReactFeedSproutsComposerX12.release();};l.prototype.$ReactFeedSproutsComposerX16=function(){c('Arbiter').inform(c('ReactComposerEvents').POST_SUCCEEDED+this.$ReactFeedSproutsComposerX3);this.$ReactFeedSproutsComposerX18();};f.exports=l;}),null);