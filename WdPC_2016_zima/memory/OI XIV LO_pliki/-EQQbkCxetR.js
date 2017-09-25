if (self.CavalryLogger) { CavalryLogger.start_js(["g\/3CY"]); }

__d('VaultBoxURI',['URI'],(function a(b,c,d,e,f,g){var h={PHOTOS_SYNCED:'photos_synced',isVaultBoxURI:function i(j){var k=new RegExp("\/"+h.PHOTOS_SYNCED+"\/?$");return j.getPath().match(k)&&j.getQueryData().hasOwnProperty('view_image');},isVaultArchiveURI:function i(j){var k=new RegExp("\/"+h.PHOTOS_SYNCED+"\/?$");return j.getPath().match(k);},getSyncedTabURI:function i(){return new (c('URI'))('/me/'+h.PHOTOS_SYNCED).getQualifiedURI();}};f.exports=h;}),null);
__d("XNotificationsStoryController",["XController"],(function a(b,c,d,e,f,g){f.exports=c("XController").create("\/notifications\/story\/",{host_element_id:{type:"String",required:true},alert_id:{type:"String",required:true}});}),null);
__d('NotificationListItem.react',['cx','csx','fbt','invariant','ix','AbstractPopoverButton.react','AsyncDialog','AsyncRequest','AsyncResponse','Banzai','BanzaiLogger','BizSiteIdentifier.brands','Bootloader','BootloadedComponent.react','Event','FlexibleBlock.react','Image.react','ImageBlock.react','JSResource','Keys','Link.react','List.react','LogicalGridCell.react','LogicalGridRow.react','NotificationAttachmentConfig','NotificationInterpolator','NotificationPhotoThumbnail','NotificationTokens','NotificationURI','NotificationUserActions','NotifTestIDs','Parent','PopoverMenu.react','React','ReactDOM','ReadToggle.react','Style','TextWithEntities.react','Timestamp.react','URI','VaultBoxURI','VideoPlayerOrigins','XNotificationsStoryController','ReactXUIMenu','XUISpinner.react','ge'],(function a(b,c,d,e,f,g,h,i,j,k,l){var m,n,o=c('ReactXUIMenu').Item,p=10000;m=babelHelpers.inherits(q,c('React').Component);n=m&&m.prototype;function q(){var r,s;'use strict';for(var t=arguments.length,u=Array(t),v=0;v<t;v++)u[v]=arguments[v];return s=(r=n.constructor).call.apply(r,[this].concat(u)),this.prefetched=false,this.isLiveVideo=null,this.$NotificationListItem1=false,this.state={showingOptions:false,negativeFeedbackConfirmation:null,canReportAsSpam:false,spamReportConfirmation:null,sendingFeedback:false,mayUndoHide:false,notifOptionConfirmation:null,isBizSite:c('BizSiteIdentifier.brands').isBizSite()},this.$NotificationListItem2=function(){if(!this.prefetched&&this.$NotificationListItem3())c('Bootloader').loadModules(["VideoPlayerSnowliftReactConfig","VideoPlayerMetaData"],function(w,x){if(w.shouldPrefetchMpd()){x.genPrefetch(this.$NotificationListItem4());this.prefetched=true;setTimeout(function(){this.prefetched=false;}.bind(this),p);}}.bind(this),'NotificationListItem.react');}.bind(this),this.$NotificationListItem5=function(w){var x=c('XNotificationsStoryController').getURIBuilder().setString('host_element_id','workHubNotifStories').setString('alert_id',this.props.alert_id).getURI();if(!c('ge')('workHubNotifSpinner'))c('ReactDOM').render(c('React').createElement(c('XUISpinner.react'),{size:'large',id:'workHubNotifSpinner'}),c('ge')('workHubNotifStories'));new (c('AsyncRequest'))(x).send();this.$NotificationListItem6(w);}.bind(this),this.$NotificationListItem7=function(w){if(c('Event').getKeyCode(w.nativeEvent)==c('Keys').RETURN)this.$NotificationListItem6(w);}.bind(this),this.$NotificationListItem8=function(){if(!this.props.isRead){this.setState({readByButton:true});c('NotificationUserActions').setNextIsFromReadButton(true);}this.$NotificationListItem9();}.bind(this),this.$NotificationListItem6=function(w){this.$NotificationListItem10();if(this.props.onRead&&w)this.props.onRead(this.props.alert_id);c('NotificationUserActions').markNotificationsAsRead([this.props.alert_id]);}.bind(this),this.$NotificationListItem11=function(w){c('AsyncResponse').defaultErrorHandler(w);this.setState({sendingFeedback:false});}.bind(this),this.$NotificationListItem16=function(w){var x=w.getPayload();x.confirmation||k(0);this.setState({negativeFeedbackConfirmation:x.confirmation,canReportAsSpam:x.canReportAsSpam,sendingFeedback:false,showingOptions:true});}.bind(this),this.$NotificationListItem17=function(w){var x=w.getPayload(),y=x.confirmation,z=x.canReportAsSpam;y||k(0);this.setState({negativeFeedbackConfirmation:y,canReportAsSpam:z,mayUndoHide:true,sendingFeedback:false,showingOptions:true});}.bind(this),this.$NotificationListItem18=function(w){var x=w.getPayload().spamReportConfirmation;this.setState({negativeFeedbackConfirmation:null,spamReportConfirmation:x,sendingFeedback:false});}.bind(this),this.$NotificationListItem20=function(){this.setState({notifOptionConfirmation:null,negativeFeedbackConfirmation:null,sendingFeedback:false,showingOptions:false});}.bind(this),this.$NotificationListItem22=function(){c('NotificationUserActions').markNotificationAsSpam(this.props.alert_id,this.$NotificationListItem18,this.$NotificationListItem11);this.setState({sendingFeedback:true});}.bind(this),this.$NotificationListItem32=function(){this.props.onChevronHide();this.$NotificationListItem33('close');}.bind(this),this.$NotificationListItem31=function(){this.props.onChevronShow();this.$NotificationListItem33('open');var w={notif_type:this.props.notif_type};c('Banzai').post('notif_chevron_on_click',w);}.bind(this),this.$NotificationListItem34=function(w){this.setState({showingOptions:true,sendingFeedback:false,notifOptionConfirmation:w});}.bind(this),s;}q.prototype.$NotificationListItem9=function(){'use strict';!this.props.isRead&&this.$NotificationListItem6();};q.prototype.$NotificationListItem10=function(){'use strict';if(this.$NotificationListItem3()){this.$NotificationListItem1=true;c('Bootloader').loadModules(["PhotoSnowliftVideoNode","VideoPlayerSnowliftReactConfig"],function(r,s){if(s.shouldRenderVideoOnClick())r.mayBeRenderLiveVideo(this.$NotificationListItem4(),c('VideoPlayerOrigins').NOTIFICATIONS);}.bind(this),'NotificationListItem.react');}};q.prototype.$NotificationListItem12=function(){'use strict';if(this.$NotificationListItem3()&&this.$NotificationListItem13())c('Bootloader').loadModules(["PhotoSnowliftVideoNode","VideoPlayerSnowliftReactConfig"],function(r,s){if(s.shouldRenderVideoOnNotificationOpen())r.mayBeRenderLiveVideo(this.$NotificationListItem4(),c('VideoPlayerOrigins').NOTIFICATIONS);}.bind(this),'NotificationListItem.react');};q.prototype.$NotificationListItem14=function(){'use strict';if(this.$NotificationListItem3()&&!this.$NotificationListItem13()&&!this.$NotificationListItem1)c('Bootloader').loadModules(["PhotoSnowliftVideoNode","VideoPlayerSnowliftReactConfig"],function(r,s){if(s.shouldRenderVideoOnNotificationOpen())r.destroyVideoNodeOfID(this.$NotificationListItem4());}.bind(this),'NotificationListItem.react');this.$NotificationListItem1=false;};q.prototype.$NotificationListItem15=function(){'use strict';if(this.$NotificationListItem3()&&this.$NotificationListItem13())c('Bootloader').loadModules(["VideoPlayerMetaData","VideoPlayerSnowliftReactConfig"],function(r,s){var t=s.shouldFetchVideoDataOnNotificationOpen();if(t)r.genVideoData(this.$NotificationListItem4(),{forceRefetch:true});}.bind(this),'NotificationListItem.react');};q.prototype.$NotificationListItem19=function(){'use strict';c('NotificationUserActions').markNotificationAsHidden(this.props.alert_id,this.$NotificationListItem16,this.$NotificationListItem11);this.setState({sendingFeedback:true,mayUndoHide:true});};q.prototype.$NotificationListItem21=function(){'use strict';var r=this.props.negative?this.props.negative.subscription_level:null;c('NotificationUserActions').markNotificationAsVisible(this.props.alert_id,r,this.$NotificationListItem20,this.$NotificationListItem11);this.setState({sendingFeedback:true});};q.prototype.$NotificationListItem23=function(){'use strict';c('NotificationUserActions').markAppAsHidden(this.props.alert_id,this.props.application.id,this.$NotificationListItem17,this.$NotificationListItem11);this.setState({sendingFeedback:true});};q.prototype.$NotificationListItem24=function(){'use strict';c('NotificationUserActions').markAppAsVisible(this.props.alert_id,this.props.application.id,function(){this.setState({negativeFeedbackConfirmation:null,sendingFeedback:false,showingOptions:false,mayUndoHide:false});}.bind(this),this.$NotificationListItem11);this.setState({sendingFeedback:true});};q.prototype.$NotificationListItem25=function(r){'use strict';if(r)return c('React').createElement(c('Image.react'),{src:r.uri,className:"_42td",'aria-hidden':true});return c('React').createElement('span',null);};q.prototype.$NotificationListItem26=function(r){'use strict';var s=void 0;try{s=JSON.parse(this.props.tracking);}catch(t){k(0);}return JSON.stringify(babelHelpers['extends']({},s,r));};q.prototype.$NotificationListItem27=function(){'use strict';this.setState({showingOptions:false});};q.prototype.$NotificationListItem28=function(r){'use strict';var s=new (c('URI'))('/ajax/bugs/employee_report').setQueryData({client_notifs:JSON.stringify(this.props.getDebugData()),notif_alert_id:this.props.alert_id}).toString();c('AsyncDialog').bootstrap(s,r,'dialog');};q.prototype.$NotificationListItem29=function(){'use strict';if(!this.props.menu_options||!this.props.menu_options.length)return null;var r="_1_0c"+(' '+"_55m9"),s=Object.assign({},this.props);delete s.parent;var t=c('React').createElement(c('ReactXUIMenu'),null,this.props.menu_options?this.props.menu_options.map(function(w){var x=function(event){var y=w.client_action==='REPORT_BUG';if(y){this.$NotificationListItem28(event.target);}else this.$NotificationListItem30(w.server_action);}.bind(this);return c('React').createElement(o,{onclick:x,key:w.client_action+w.server_action},c('React').createElement('div',{className:"_18qh"},w.text));}.bind(this)):null),u={button:c('React').createElement('a',{href:'#','aria-label':'Notification options',className:"_1_0d"})},v=c('React').createElement(c('PopoverMenu.react'),{'data-testid':c('NotifTestIDs').CHEVRON,alignh:'right',menu:t,className:r,disableArrowKeyActivation:true,onShow:this.$NotificationListItem31,onHide:this.$NotificationListItem32},c('React').createElement(c('AbstractPopoverButton.react'),{config:u,haschevron:false,image:null,label:null}));return v;};q.prototype.shouldComponentUpdate=function(r,s){'use strict';return this.props.visible!==r.visible||this.props.isRead!==r.isRead||this.props.timestamp!==r.timestamp||this.props.paused!==r.paused||this.state.showingOptions!==s.showingOptions||this.state.sendingFeedback!==s.sendingFeedback||this.state.canReportAsSpam!==s.canReportAsSpam||this.state.spamReportConfirmation!==s.spamReportConfirmation;};q.prototype.componentWillReceiveProps=function(r){'use strict';if(this.props.paused&&!r.paused&&!this.props.visible&&this.state.mayUndoHide)this.setState({mayUndoHide:false});};q.prototype.componentDidMount=function(){'use strict';if(this.$NotificationListItem3())c('Bootloader').loadModules(["VideoPlayerMetaData","PhotoSnowliftVideoNode","VideoPlayerSnowliftReactConfig"],function(r,s,t){var u=t.shouldFetchVideoDataOnNotificationOpen();if(!u)r.genVideoData(this.$NotificationListItem4()).done();}.bind(this),'NotificationListItem.react');this.$NotificationListItem12();this.$NotificationListItem15();};q.prototype.componentDidUpdate=function(){'use strict';this.$NotificationListItem12();this.$NotificationListItem14();this.$NotificationListItem15();};q.prototype.$NotificationListItem13=function(){'use strict';var r=c('ReactDOM').findDOMNode(this),s=c('Parent').bySelector(r,".__tw"),t=s?s.parentNode:null;return t?c('Style').get(t,'display')!=='none':false;};q.prototype.$NotificationListItem33=function(r){'use strict';var s={event:r,notif_type:this.props.notif_type,notif_id:parseInt(c('NotificationTokens').untokenizeIDs([this.props.alert_id])[0],10)};c('BanzaiLogger').log('NotifJewelMenuLoggerConfig',s);};q.prototype.$NotificationListItem35=function(){'use strict';if(this.props.row!='undefined')return this.$NotificationListItem26({row:this.props.row});return this.props.tracking;};q.prototype.$NotificationListItem30=function(r){'use strict';this.setState({sendingFeedback:true,mayUndoHide:true});c('NotificationUserActions').sendNotifOption(this.props.alert_id,this.$NotificationListItem34,this.$NotificationListItem11,r);};q.prototype.$NotificationListItem36=function(r){'use strict';this.setState({sendingFeedback:true});c('NotificationUserActions').undoNotifOption(this.props.alert_id,this.$NotificationListItem20,this.$NotificationListItem11,r);};q.prototype.$NotificationListItem37=function(){'use strict';var r=this.props,s=r.attachments,t=r.feedback_context,u=r.attached_story,v=[];if(s)v.push.apply(v,s);if(t&&t.relevant_comments)v.push.apply(v,t.relevant_comments);if(u&&u.attachments)v.push.apply(v,u.attachments);return v.some(function(w){if(!w.style_list||!w.style_list.length)return false;var x=w.style_list[0];return !!c('NotificationAttachmentConfig').snowliftStyles[x];});};q.prototype.$NotificationListItem4=function(){'use strict';var r=this.$NotificationListItem35(),s=JSON.parse(r);return s.content_id;};q.prototype.$NotificationListItem3=function(){'use strict';if(this.isLiveVideo===null){var r=this.$NotificationListItem35();this.isLiveVideo=r.indexOf('live_video')!==-1;}return this.isLiveVideo;};q.prototype.$NotificationListItem38=function(){'use strict';var r=this.props,s=r.eligible_buckets,t=r.isRead;return (!t&&s&&s.indexOf('so_notifications')!==-1);};q.prototype.$NotificationListItem39=function(){'use strict';if(!this.$NotificationListItem38())return null;return (c('React').createElement('div',{className:"_9u0 _9u1"},c('React').createElement(c('BootloadedComponent.react'),{bootloadPlaceholder:c('React').createElement('div',null),bootloadLoader:c('JSResource')('RelationshipDelightsHearts.react').__setRef('NotificationListItem.react'),numParticles:10})));};q.prototype.render=function(){'use strict';if(!this.props.visible&&!this.state.mayUndoHide)return c('React').createElement('li',{className:"_4_62"});var r="_33c"+(!this.props.isRead?' '+"jewelItemNew":'')+(this.state.showingOptions?' '+"_4ag":'')+(this.state.sendingFeedback?' '+"_4m8s":'')+(this.$NotificationListItem38()?' '+"_9u2":''),s=this.$NotificationListItem35(),t=this.props.rowIndex;if(this.state.negativeFeedbackConfirmation){var u=this.state.negativeFeedbackConfirmation,v=null,w=null;if(this.state.canReportAsSpam)w=c('React').createElement(c('List.react'),{border:'none',spacing:'small',className:"_1v4c"},c('React').createElement('li',null,c('React').createElement('a',{href:'#',onClick:this.$NotificationListItem22,className:'mls'},j._("Zg\u0142o\u015b aplikacj\u0119 wysy\u0142aj\u0105c\u0105 spam"))));return (c('React').createElement('li',{className:r,'data-gt':s},c('React').createElement(c('LogicalGridRow.react'),{className:"_dre",rowIndex:t,component:c('React').createElement('div',null)},c('React').createElement(c('LogicalGridCell.react'),{columnIndex:0,component:c('React').createElement('div',null)},c('React').createElement('div',{className:"_4ai"},c('React').createElement(c('TextWithEntities.react'),{interpolator:c('NotificationInterpolator'),ranges:u.ranges,aggregatedranges:u.aggregated_ranges,text:u.text}),v),w))));}var x=this.state.spamReportConfirmation;if(x)return (c('React').createElement('li',{className:r,'data-gt':s},c('React').createElement(c('LogicalGridRow.react'),{className:"_dre",rowIndex:t,component:c('React').createElement('div',null)},c('React').createElement(c('LogicalGridCell.react'),{columnIndex:0,component:c('React').createElement('div',null)},c('React').createElement('div',{className:"_4ai"},c('React').createElement(c('TextWithEntities.react'),{interpolator:c('NotificationInterpolator'),ranges:x.ranges,aggregatedranges:x.aggregated_ranges,text:x.text}))))));if(this.state.notifOptionConfirmation){u=this.state.notifOptionConfirmation;return (c('React').createElement('li',{className:r,'data-gt':s},c('React').createElement(c('LogicalGridRow.react'),{className:"_dre",rowIndex:t,component:c('React').createElement('div',null)},c('React').createElement(c('LogicalGridCell.react'),{columnIndex:0,component:c('React').createElement('div',null)},c('React').createElement('div',{className:"_4ai"},c('React').createElement(c('TextWithEntities.react'),{interpolator:c('NotificationInterpolator'),ranges:u.ranges,aggregatedranges:u.aggregated_ranges,text:u.text&&u.text.text?u.text.text:''}),c('React').createElement('a',{href:'#',onClick:function(){this.$NotificationListItem36(u.undo_action);}.bind(this),className:'mls'},j._("Cofnij"))),c('React').createElement(c('List.react'),{border:'none',spacing:'small',className:"_1v4c"},u.follow_up_options.map?u.follow_up_options.map(function(sa){return (c('React').createElement('li',{key:sa.client_action+sa.server_action},c('React').createElement('a',{onClick:function(){this.$NotificationListItem30(sa.server_action);}.bind(this),href:'#',className:'mls'},sa.text)));}.bind(this)):null)))));}var y=null;if(this.props.title)y=c('React').createElement(c('TextWithEntities.react'),{interpolator:c('NotificationInterpolator'),ranges:this.props.title.ranges,aggregatedranges:this.props.title.aggregated_ranges,text:this.props.title.text,renderEmoji:true,renderEmoticons:true});var z=null,aa=c('NotificationURI').localize(this.props.url),ba=null;if(!this.props.noPhotoPreviews)ba=c('NotificationPhotoThumbnail').getThumbnail(this.props.attachments,this.props.attached_story,this.props.feedback_context);var ca=this.$NotificationListItem37()&&c('NotificationURI').snowliftable(aa),da=c('NotificationURI').isVaultSetURI(aa),ea=c('NotificationURI').isAlbumDraftRecoveryDialogURI(aa),fa="_55ma"+(' '+"_55m9"),ga=c('React').createElement(c('ReadToggle.react'),{className:fa,isRead:!!this.props.isRead,onClick:this.$NotificationListItem8,readLabel:j._("Przeczytane"),unreadLabel:j._("Oznacz jako przeczytane")}),ha=this.$NotificationListItem29(),ia=ca||da||ea?aa:this.props.ajaxify_url,ja=null,ka=null,la=da?c('VaultBoxURI').getSyncedTabURI().toString():aa;if(ca){ja='theater';}else if(ea){ja='async-post';}else if(c('NotificationURI').isQuicksilverURI(ia)){ja='dialog-post';}else if(da||ia)ja='dialog';var ma=this.props.actors[0],na=c('React').createElement(c('Image.react'),{src:ma&&ma.profile_picture?ma.profile_picture.uri:l("images\/profile\/picture\/silhouette\/female_50.png"),alt:'',className:(!this.props.isNotifsPage?"_33h":'')+(this.props.isNotifsPage?' '+"_12u1":'')}),oa=c('React').createElement('div',null,c('React').createElement(c('LogicalGridCell.react'),{columnIndex:1,component:c('React').createElement('span',null)},ga),c('React').createElement(c('LogicalGridCell.react'),{columnIndex:2,component:c('React').createElement('span',null),disableFocusRecovery:true},ha)),pa=c('React').createElement(c('ImageBlock.react'),null,na,c('React').createElement(c('FlexibleBlock.react'),{flex:c('FlexibleBlock.react').FLEX.left},c('React').createElement('div',{className:"_4l_v"},y,c('React').createElement(c('ImageBlock.react'),{className:"_33f"+(this.state.isBizSite?' '+"_2g48":'')},c('React').createElement(c('Image.react'),{className:"_10cu",src:this.props.icon.uri}),c('React').createElement('span',null,c('React').createElement(c('Timestamp.react'),{shorten:this.props.shortenTimestamp,time:this.props.timestamp.time,text:this.props.timestamp.text,verbose:this.props.timestamp.verbose,className:"_33g"})))),this.$NotificationListItem25(ba))),qa=null;if(this.props.enableHubView){qa=c('React').createElement(c('Link.react'),{href:'#','aria-label':y,className:"_33e"+(' '+"_1_0e"),onClick:this.$NotificationListItem5},pa);}else qa=c('React').createElement('a',{href:la,ajaxify:ia,className:"_33e"+(' '+"_1_0e"),rel:ja,onClick:ka,onMouseOver:this.$NotificationListItem2,onMouseDown:this.$NotificationListItem6,onKeyDown:this.$NotificationListItem7},pa);var ra=this.$NotificationListItem39();return (c('React').createElement('li',{className:r,'data-gt':s,'data-alert-id':this.props.alert_id,onMouseLeave:z},c('React').createElement(c('LogicalGridRow.react'),{className:"_dre anchorContainer",rowIndex:t,component:c('React').createElement('div',null)},c('React').createElement(c('LogicalGridCell.react'),{columnIndex:0,component:c('React').createElement('div',null)},ra,qa),oa)));};f.exports=q;}),null);
__d('NotificationListPropTypes',['React'],(function a(b,c,d,e,f,g){'use strict';var h=c('React').PropTypes,i={negativeTracking:h.object,tracking:h.string,notifs:h.object,afterScroll:h.func,enableHubView:h.bool,onChevronShow:h.func,onChevronHide:h.func,onRead:h.func,canFetchMore:h.bool,hiddenState:h.object,readState:h.object,showingChevron:h.bool,paused:h.bool,maxHeight:h.number,shouldScroll:h.bool,notifTab:h.string};f.exports=i;}),null);
__d('NotificationPageList.react',['cx','fbt','ErrorBoundary.react','Event','getViewportDimensions','LoadingIndicator.react','LogicalGrid.react','NotificationListItem.react','NotificationListPropTypes','NotifTestIDs','React','ReactDOM','Vector','debounce','getObjectValues','isEmpty'],(function a(b,c,d,e,f,g,h,i){var j,k;j=babelHelpers.inherits(l,c('React').Component);k=j&&j.prototype;function l(){var m,n;'use strict';for(var o=arguments.length,p=Array(o),q=0;q<o;q++)p[q]=arguments[q];return n=(m=k.constructor).call.apply(m,[this].concat(p)),this.$NotificationPageList3=function(){var r=c('ReactDOM').findDOMNode(this.refs.notifList),s=this.$NotificationPageList2();this.props.afterScroll(this.$NotificationPageList1(),r,s);}.bind(this),this.$NotificationPageList5=function(){return c('getObjectValues')(this.props.notifs).map(function(r){return JSON.stringify(r);});}.bind(this),n;}l.prototype.$NotificationPageList1=function(){'use strict';var m=this.refs.loading;if(!m)return false;var n=c('Vector').getElementPosition(c('ReactDOM').findDOMNode(m),'viewport').y;return n<c('Vector').getViewportDimensions().y;};l.prototype.$NotificationPageList2=function(){'use strict';var m=c('getViewportDimensions').withoutScrollbars();return {top:0,bottom:m.height,left:0,right:m.width};};l.prototype.$NotificationPageList4=function(m,n){'use strict';return n.indexOf(m);};l.prototype.componentDidUpdate=function(){'use strict';this.$NotificationPageList3();};l.prototype.componentDidMount=function(){'use strict';c('Event').listen(window,'scroll',c('debounce')(this.$NotificationPageList3,200));this.$NotificationPageList3();};l.prototype.$NotificationPageList6=function(){'use strict';var m=c('getObjectValues')(this.props.notifs).map(function(n){return n.alert_id;});return c('getObjectValues')(this.props.notifs).map(function(n,o){var p=n.alert_id,q=this.$NotificationPageList4(p,m);return (c('React').createElement(c('ErrorBoundary.react'),{key:p},c('React').createElement(c('NotificationListItem.react'),babelHelpers['extends']({getDebugData:this.$NotificationPageList5,enableHubView:this.props.enableHubView,isNotifsPage:true,isRead:this.props.readState[p],negativeTracking:this.props.negativeTracking,noPhotoPreviews:true,onChevronHide:this.props.onChevronHide,onChevronShow:this.props.onChevronShow,paused:this.props.paused,row:q,rowIndex:o,shortenTimestamp:this.props.shortenTimestamp,visible:!this.props.hiddenState[p]},n))));}.bind(this));};l.prototype.render=function(){'use strict';var m=null,n=null,o=c('React').createElement('ul',{'data-gt':this.props.tracking,'data-testid':c('NotifTestIDs').SEE_ALL_LIST});if(!c('isEmpty')(this.props.notifs)){m=c('React').createElement(c('LogicalGrid.react'),{ref:'notifList',component:o},this.$NotificationPageList6());}else if(!this.props.canFetchMore)m=c('React').createElement('div',{className:"_44_s",'data-testid':c('NotifTestIDs').SEE_ALL_LIST},i._("Brak nowych powiadomie\u0144"));if(this.props.canFetchMore)n=c('React').createElement(c('LoadingIndicator.react'),{color:'white',size:'large',ref:'loading',className:"_44_t"});var p=null;if(this.props.upsell){var q=this.props.upsell.module;p=c('React').createElement(q,babelHelpers['extends']({isPage:true},this.props.upsell.props));}var r="_44_u"+(this.props.showingChevron?' '+"_44_v":'');return (c('React').createElement('div',{className:r},p,m,n));};l.propTypes=c('NotificationListPropTypes');f.exports=l;}),null);
__d('MobileSmsActivationController',['AsyncRequest','AsyncResponse','Dialog','goURI','ge','ReloadPage','$','DeprecatedCSSMiscellany'],(function a(b,c,d,e,f,g){var h=c('DeprecatedCSSMiscellany').hide,i=c('DeprecatedCSSMiscellany').show;function j(k,l,m,n,o,p){Object.assign(this,{profile_id:k,parent:parent,source:l,misc:m,carrier:null,AJAX_URI:'/ajax/mobile/activation.php',redirect_uri:null,cb_obj:n,status_id:p||'mobile_throbber'});if(o){this.goVerification();}else this.start();j.instance=this;}j.instance={};j.getInstance=function(){return j.instance;};j.show_carriers=function(){var k=c('$')('selected_country').value,l=c('$')('carrier_country').value;if(k)h(c('$')(k+'_carrier_select'));c('$')('selected_country').value=l;c('$')('selected_carrier').value=0;i(c('$')(l+'_carrier_select'));};j.update_carrier=function(){var k=c('$')('selected_country').value+'_carrier_select';c('$')('selected_carrier').value=c('$')(k).value;};Object.assign(j.prototype,{goStep:function k(l){if(l==2){this.getShortCode();return;}else if(l==3){this.getConfirmCode();return;}this.start();},start:function k(l){new (c('AsyncRequest'))().setURI(this.AJAX_URI).setData({profile_id:this.profile_id,get_carriers:1,source:this.source,misc:this.misc,error:l}).setHandler(this.showCarriers.bind(this)).setStatusElement(c('$')(this.status_id)).send();},showCarriers:function k(l){var m=l.getPayload();if(!m)return;if(this.cb_obj&&this.cb_obj.onShowCarriers){this.cb_obj.onShowCarriers(m);}else new (c('Dialog'))().setTitle(m.title).setBody(m.html).setHandler(this.getShortCode.bind(this)).setButtons([c('Dialog').NEXT,c('Dialog').CANCEL]).show();},getShortCode:function k(){if(!this.carrier){this.carrier=parseInt(c('$')('selected_carrier').value,10);if(!this.carrier){this.start(true);return false;}}c('Dialog').getCurrent()&&c('Dialog').getCurrent().setButtonsMessage('<img src="/images/loaders/indicator_blue_small.gif" />');new (c('AsyncRequest'))().setURI(this.AJAX_URI).setData({profile_id:this.profile_id,get_code:1,carrier:this.carrier,source:this.source,misc:this.misc}).setHandler(this.showShortCode.bind(this)).send();return false;},showShortCode:function k(l){var m=l.getPayload();if(this.cb_obj&&this.cb_obj.onShowShortCode){this.cb_obj.onShowShortCode(m);}else new (c('Dialog'))().setTitle(m.title).setBody(m.html).setHandler(this.activate.bind(this)).setButtons([c('Dialog').NEXT,c('Dialog').CANCEL]).show();},activate:function k(){var l=c('$')('sms_code').value;if(!l)return;var m=c('ge')('profile_add');m=m?m.checked:null;var n=c('ge')('message_on');n=n?n.checked:null;new (c('AsyncRequest'))().setURI(this.AJAX_URI).setData({profile_id:this.profile_id,confirm:1,code:l,profile_add:m,message_on:n,source:this.source,misc:this.misc}).setHandler(this.confirmCode.bind(this)).setErrorHandler(this.confirmCode.bind(this)).send();},confirmCode:function k(l){var m=l.getPayload();if(!l.error&&m.success){if(this.cb_obj&&this.cb_obj.onActivationSuccess){this.cb_obj.onActivationSuccess(m);}else{if(m.redirect_now){c('goURI')(m.redirect,m.force_redirect);return;}if(m.redirect==null)return;this.redirect_uri=m.redirect;new (c('Dialog'))().setTitle(m.title).setBody(m.html).setHandler(this.redirect.bind(this)).setButtons([c('Dialog').OK]).show();}}else if(this.cb_obj&&this.cb_obj.onActivationFailure){this.cb_obj.onActivationFailure(l);}else c('AsyncResponse').defaultErrorHandler.call(this,l);},redirect:function k(){if(this.redirect_uri=='reload'){c('ReloadPage').now();}else c('goURI')(this.redirect_uri);},goVerification:function k(){new (c('AsyncRequest'))().setURI(this.AJAX_URI).setData({profile_id:this.profile_id,show_verification:1,source:this.source,misc:this.misc}).setHandler(this.displayVerification.bind(this)).send();return false;},displayVerification:function k(l){var m=l.getPayload();if(this.cb_obj&&this.cb_obj.onDisplayVerification){this.cb_obj.onDisplayVerification(m);}else new (c('Dialog'))().setTitle(m.title).setBody(m.html).setHandler(this.completeVerification.bind(this,l)).setButtons([c('Dialog').OK]).show();},completeVerification:function k(l){var m=l.getPayload();if(this.cb_obj)this.cb_obj.onVerificationComplete(m);}});f.exports=j;}),null);
__d('legacy:mobile-sms-activation',['MobileSmsActivationController'],(function a(b,c,d,e,f,g){b.MobileSmsActivationController=c('MobileSmsActivationController');b.mobile_activation_show_carriers=c('MobileSmsActivationController').show_carriers;b.mobile_activation_update_carrier=c('MobileSmsActivationController').update_carrier;}),3);
__d('SettingsMobileRemoveLink',['AsyncRequest','DOMQuery','Button','Event'],(function a(b,c,d,e,f,g){function h(i,j,k,l,m){'use strict';this.$SettingsMobileRemoveLink1=i;this.$SettingsMobileRemoveLink2=j;this.$SettingsMobileRemoveLink3=k;c('Event').listen(i,'click',function(){j.conditionShow(!j.isShown());});if(k.canDelete)j.subscribe('confirm',this.$SettingsMobileRemoveLink4.bind(this));if(l&&m)c('Event').listen(l,'change',function(n){c('Button').setEnabled(m,n.target.checked);});}h.prototype.getRoot=function(){'use strict';return this.$SettingsMobileRemoveLink1;};h.prototype.getLink=function(){'use strict';return c('DOMQuery').find(this.getRoot(),'a');};h.prototype.$SettingsMobileRemoveLink4=function(){'use strict';this.$SettingsMobileRemoveLink2.hide();new (c('AsyncRequest'))('/ajax/settings/mobile/delete_phone.php').setData({phone_number:this.$SettingsMobileRemoveLink3.phoneNumber,profile_id:this.$SettingsMobileRemoveLink3.profileID}).send();};f.exports=h;}),null);