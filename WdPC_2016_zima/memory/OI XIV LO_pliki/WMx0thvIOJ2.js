if (self.CavalryLogger) { CavalryLogger.start_js(["rdCCk"]); }

__d("ProfileDOMID",[],(function a(b,c,d,e,f,g){f.exports={ABOVE_HEADER_TIMELINE:"pagelet_above_header_timeline",ABOVE_HEADER_TIMELINE_PLACEHOLDER:"above_header_timeline_placeholder",COVER:"fbProfileCover",MAIN_COLUMN:"pagelet_main_column",MAIN_COLUMN_PERSONAL:"pagelet_main_column_personal",MAIN_COLUMN_PERSONAL_OTHER:"pagelet_main_column_personal_other",RIGHT_SIDEBAR:"pagelet_right_sidebar",TAB_LOAD_INDICATOR:"tab_load_indicator",TOP_SECTION:"timeline_top_section",FIG_PROFILE_PIC:"profile_fig_profile_pic",FIG_ACTION_BAR:"profile_fig_action_bar",FIG_SUBTITLE:"profile_fig_subtitle",DISCOVERY_INTENT_BUTTON:"discovery_intent_button",DISCOVERY_INTENT_BANNER:"discovery_intent_banner",PREFIX_MAIN_COLUMN_PERSONAL:"pagelet_main_column_personal_"};}),null);
__d("TimelineScrollJankEventTypes",[],(function a(b,c,d,e,f,g){f.exports={BOTTOM_OUT:"bottom_out"};}),null);
__d("TimelineScrubberKey",[],(function a(b,c,d,e,f,g){f.exports={MONTH:"month",RECENT_ACTIVITY:"recent",YEAR:"year"};}),null);
__d('EgoAdsObjectSet',['csx','DataAttributeUtils','DOM'],(function a(b,c,d,e,f,g,h){var i=void 0;function j(l){'use strict';i=l;this._allEgoUnits=[];this._egoUnits=[];}j.prototype.init=function(l){'use strict';this._allEgoUnits=l;this._egoUnits=[];this._allEgoUnits.forEach(function(m){var n=k(m);if(!n||!n.holdout)this._egoUnits.push(m);},this);};j.prototype.getCount=function(){'use strict';return this._egoUnits.length;};j.prototype.forEach=function(l,m){'use strict';this._egoUnits.forEach(l,m);};j.prototype.getUnit=function(l){'use strict';return this._egoUnits[l];};j.prototype.getHoldoutAdIDsForSpace=function(l,m){'use strict';if(!l||!m)return [];var n=[];for(var o=0;l>0&&o<this._allEgoUnits.length;o++){var p=this._allEgoUnits[o],q=m(p),r=k(p);if(l>=q&&r&&r.holdout)n.push(r.adid);l-=q;}return n;};j.prototype.getHoldoutAdIDsForNumAds=function(l){'use strict';l=Math.min(l,this._allEgoUnits.length);var m=[];for(var n=0;n<l;n++){var o=this._allEgoUnits[n],p=k(o);if(p&&p.holdout)m.push(p.adid);}return m;};function k(l){var m=c('DOM').scry(l,i||"div._4u8")[0],n=m&&c('DataAttributeUtils').getDataAttribute(m,'data-ad');return n&&JSON.parse(n)||undefined;}f.exports=j;}),null);
__d('EntStreamGroupMall',['DOM','$','ge'],(function a(b,c,d,e,f,g){var h={replacePager:function i(j){c('DOM').setContent(c('$')('pagelet_group_pager'),j);},replaceFilesPager:function i(j,k){c('DOM').setContent(c('$')('group_files_pager_'+k),j);},replacePostApprovalSection:function i(j){var k=c('ge')('pagelet_consolidate_posts');if(k!==null)c('DOM').setContent(k,j);},replaceScheduledPostsSection:function i(j){var k=c('ge')('pagelet_scheduled_posts');if(k!==null)c('DOM').setContent(k,j);}};f.exports=h;}),null);
__d('ProfileTimelineUITypedLogger',['Banzai','GeneratedLoggerUtils','nullthrows'],(function a(b,c,d,e,f,g){'use strict';function h(){this.clear();}h.prototype.log=function(){c('GeneratedLoggerUtils').log('logger:ProfileTimelineUILoggerConfig',this.$ProfileTimelineUITypedLogger1,c('Banzai').BASIC);};h.prototype.logVital=function(){c('GeneratedLoggerUtils').log('logger:ProfileTimelineUILoggerConfig',this.$ProfileTimelineUITypedLogger1,c('Banzai').VITAL);};h.prototype.clear=function(){this.$ProfileTimelineUITypedLogger1={};return this;};h.prototype.updateData=function(j){this.$ProfileTimelineUITypedLogger1=babelHelpers['extends']({},this.$ProfileTimelineUITypedLogger1,j);return this;};h.prototype.setEvent=function(j){this.$ProfileTimelineUITypedLogger1.event=j;return this;};h.prototype.setEventMetadata=function(j){this.$ProfileTimelineUITypedLogger1.event_metadata=c('GeneratedLoggerUtils').serializeMap(j);return this;};h.prototype.setProfileID=function(j){this.$ProfileTimelineUITypedLogger1.profile_id=j;return this;};h.prototype.setRelationshipType=function(j){this.$ProfileTimelineUITypedLogger1.relationship_type=j;return this;};h.prototype.setUIComponent=function(j){this.$ProfileTimelineUITypedLogger1.ui_component=j;return this;};h.prototype.setVC=function(j){this.$ProfileTimelineUITypedLogger1.vc=j;return this;};var i={event:true,event_metadata:true,profile_id:true,relationship_type:true,ui_component:true,vc:true};f.exports=h;}),null);
__d('ScrollingPager',['Arbiter','CSS','DOM','OnVisible','UIPagelet','$','ge'],(function a(b,c,d,e,f,g){var h={};function i(j,k,l,m){'use strict';this.scroll_loader_id=j;this.pagelet_src=k;this.data=l;this.options=m||{};if(this.options.target_id){this.target_id=this.options.target_id;this.options.append=true;}else this.target_id=j;this.scroll_area_id=this.options.scroll_area_id;this.handler=null;}i.prototype.setBuffer=function(j){'use strict';this.options.buffer=j;this.onvisible&&this.onvisible.setBuffer(j);};i.prototype.getBuffer=function(){'use strict';return this.options.buffer;};i.prototype.register=function(){'use strict';this.onvisible=new (c('OnVisible'))(c('$')(this.scroll_loader_id),this.getHandler(),false,this.options.buffer,false,c('ge')(this.scroll_area_id));h[this.scroll_loader_id]=this;c('Arbiter').inform(i.REGISTERED,{id:this.scroll_loader_id});};i.prototype.getInstance=function(j){'use strict';return h[j];};i.prototype.getHandler=function(){'use strict';if(this.handler)return this.handler;function j(k){var l=c('ge')(this.scroll_loader_id);if(!l){this.onvisible.remove();return;}c('CSS').addClass(l.firstChild,'async_saving');var m=this.options.handler,n=this.options.force_remove_pager&&this.scroll_loader_id!==this.target_id;this.options.handler=function(){c('Arbiter').inform('ScrollingPager/loadingComplete');m&&m.apply(null,arguments);if(n)c('DOM').remove(l);};if(k)this.data.pager_fired_on_init=true;c('UIPagelet').loadFromEndpoint(this.pagelet_src,this.target_id,this.data,this.options);}return j.bind(this);};i.prototype.setHandler=function(j){'use strict';this.handler=j;};i.prototype.removeOnVisible=function(){'use strict';this.onvisible.remove();};i.prototype.checkBuffer=function(){'use strict';this.onvisible&&this.onvisible.checkBuffer();};i.getInstance=function(j){'use strict';return h[j];};Object.assign(i,{REGISTERED:'ScrollingPager/registered'});f.exports=i;}),null);
__d('StickyController',['CSS','Event','Style','Vector','queryThenMutateDOM'],(function a(b,c,d,e,f,g){function h(i,j,k,l){'use strict';this._element=i;this._marginTop=j;this._onchange=k;this._proxy=l||i.parentNode;this._boundQueryOnScroll=this.shouldFix.bind(this);this._boundMutateOnScroll=this._mutateOnScroll.bind(this);}h.prototype.handleScroll=function(){'use strict';c('queryThenMutateDOM')(this._boundQueryOnScroll,this._boundMutateOnScroll);};h.prototype.shouldFix=function(){'use strict';return c('Vector').getElementPosition(this._proxy,'viewport').y<=this._marginTop;};h.prototype._mutateOnScroll=function(){'use strict';var i=this.shouldFix();if(this.isFixed()!==i){c('Style').set(this._element,'top',i?this._marginTop+'px':'');c('CSS').conditionClass(this._element,'fixed_elem',i);this._onchange&&this._onchange(i);}};h.prototype.start=function(){'use strict';if(this._event)return;this._event=c('Event').listen(window,'scroll',this.handleScroll.bind(this));setTimeout(this.handleScroll.bind(this),0);};h.prototype.stop=function(){'use strict';this._event&&this._event.remove();this._event=null;};h.prototype.isFixed=function(){'use strict';return c('CSS').hasClass(this._element,'fixed_elem');};f.exports=h;}),null);
__d('ProfileNavRef',['LinkController','Parent','URI'],(function a(b,c,d,e,f,g){var h='pnref',i='data-'+h,j=false;function k(l){var m=[];l=c('Parent').byAttribute(l,i);while(l){m.unshift(l.getAttribute(i));l=c('Parent').byAttribute(l.parentNode,i);}return m.join('.');}g.track=function(){if(j)return;j=true;c('LinkController').registerHandler(function(l){var m=k(l);if(m)l.href=new (c('URI'))(l.href).addQueryData(h,m).toString();});};}),null);
__d('TimelineComponentKeys',['ImmutableObject'],(function a(b,c,d,e,f,g){var h=new (c('ImmutableObject'))({ADS:'ads',ASYNC_NAV:'async_nav',CONTENT:'content',COVER_NAV:'cover_nav',ESCAPE_HATCH:'escape_hatch',LOGGING:'logging',NAV:'nav',SCRUBBER:'scrubber',STICKY_COLUMN:'sticky_column',STICKY_HEADER:'sticky_header',STICKY_HEADER_NAV:'sticky_header_nav'});f.exports=h;}),null);
__d('TimelineConstants',[],(function a(b,c,d,e,f,g){var h={DS_LOADED:'timeline-capsule-loaded',DS_COLUMN_HEIGHT_DIFFERENTIAL:'timeline-column-diff-height',SCROLL_TO_OFFSET:100,SCRUBBER_DEFAULT_OFFSET:38,SECTION_EXPAND:'TimelineConstants/sectionExpand',SECTION_LOADING:'TimelineConstants/sectionLoading',SECTION_LOADED:'TimelineConstants/sectionLoaded',SECTION_FULLY_LOADED:'TimelineConstants/sectionFullyLoaded',SECTION_REGISTERED:'TimelineConstants/sectionRegistered',UNIT_SEGMENT_LOADED:'TimelineConstants/unitSegmentLoaded'};f.exports=h;}),null);
__d('TimelineLegacySections',['fbt','CSS','DOM','getElementText'],(function a(b,c,d,e,f,g,h){var i={},j={},k=false,l=[],m={},n={get:function o(p){return j.hasOwnProperty(p)?j[p]:null;},getAll:function o(){return j;},remove:function o(p){for(var q=0;q<l.length;q++)if(l[q]===p){l[q]=null;break;}delete j[p];},removeAll:function o(){j={};},set:function o(p,q){j[p]=q;},addOnVisible:function o(p,q){m[p]=q;},destroyOnVisible:function o(p){var q=m[p];if(q){q.remove();c('DOM').remove(q.getElement());}m[p]=null;},removeOnVisible:function o(p){var q=m[p];if(q)q.remove();},removeAllOnVisibles:function o(){Object.keys(m).forEach(function(p){return this.removeOnVisible(p);}.bind(this));},getOnVisible:function o(p){return m[p];},setMainSectionOrder:function o(p,q){l[q]=p;},getMainSectionOrder:function o(){return l;},addLoadPagelet:function o(p,q){i[p]=q;},cancelLoadPagelet:function o(p){if(i[p])i[p].cancel();},cancelLoadPagelets:function o(){Object.keys(i).forEach(function(p){return this.cancelLoadPagelet(p);}.bind(this));i={};},shouldForceNoFriendActivity:function o(){return k;},forceNoFriendActivity:function o(){k=true;},collapsePlaceHolderHeaders:function o(){var p,q,r=false;for(var s=0;s<l.length;s++){var t=l[s];if(!t)continue;var u=n.get(t);if(!u)continue;if(u.canScrollLoad()||u.isLoaded()){if(!u.isLoaded()){c('CSS').removeClass(u.getNode(),'fbTimelineTimePeriodSuppressed');c('CSS').addClass(u.getNode(),'fbTimelineTimePeriodUnexpanded');}if(p&&q){this.combineSectionHeaders(p,q);if(r)p.deactivateScrollLoad();r=true;}p=null;q=null;continue;}else if(p){q=u;u.deactivateScrollLoad();}else{p=u;q=u;if(r)u.activateScrollLoad();}c('CSS').removeClass(u.getNode(),'fbTimelineTimePeriodSuppressed');c('CSS').addClass(u.getNode(),'fbTimelineTimePeriodUnexpanded');}},combineSectionHeaders:function o(p,q){c('CSS').removeClass(q.getNode(),'fbTimelineTimePeriodUnexpanded');c('CSS').addClass(q.getNode(),'fbTimelineTimePeriodSuppressed');var r=c('DOM').find(p.getNode(),'span.sectionLabel'),s=c('DOM').find(q.getNode(),'span.sectionLabel');if(!s.getAttribute('data-original-label'))s.setAttribute('data-original-label',c('getElementText')(s));if(r.getAttribute('data-month')&&s.getAttribute('data-month')&&r.getAttribute('data-year')==s.getAttribute('data-year')){c('DOM').setContent(s,h._("Poka\u017c {month1}-{month2} {year}",[h.param('month1',s.getAttribute('data-month')),h.param('month2',r.getAttribute('data-month')),h.param('year',r.getAttribute('data-year'))]));}else if(r.getAttribute('data-year')!==s.getAttribute('data-year')){c('DOM').setContent(s,h._("Poka\u017c {year1} - {year2}",[h.param('year1',s.getAttribute('data-year')),h.param('year2',r.getAttribute('data-year'))]));}else c('DOM').setContent(s,h._("Poka\u017c {year}",[h.param('year',s.getAttribute('data-year'))]));}};f.exports=n;}),null);
__d('TimelineScrollJankLogger',['Banzai','BanzaiLogger','TimelineScrollJankEventTypes','debounceCore','emptyFunction'],(function a(b,c,d,e,f,g){var h='TimelineScrollJankLoggerConfig',i='timeline_scroll_jank',j=50;function k(event,n,o,p){c('BanzaiLogger').log(h,{event:event,profileid:n,currentsection:p,sessionid:o});}var l=c('Banzai').isEnabled(i)?c('debounceCore')(k,j):c('emptyFunction'),m={logBottomOut:l.bind(null,c('TimelineScrollJankEventTypes').BOTTOM_OUT)};f.exports=m;}),null);
__d('TimelineController',['Arbiter','BlueBar','CSS','DataStore','DOMQuery','Event','ProfileDOMID','ProfileNavRef','ProfileTabConst','ProfileTabUtils','Run','ScrollingPager','TidyArbiter','TimelineComponentKeys','TimelineConstants','TimelineLegacySections','TimelineScrollJankLogger','TimelineScrubberKey','UITinyViewportAction','Vector','$','forEachObject','ge','queryThenMutateDOM','randomInt','tidyEvent'],(function a(b,c,d,e,f,g){var h=740,i=5,j='top',k='paddingTop',l='paddingTop',m=null,n=false,o=null,p=null,q,r={},s={},t=[],u=null,v=0,w=c('Vector').getViewportDimensions(),x=false,y=false,z=false;function aa(ma,na,oa){oa=oa||[];if(r[ma])return r[ma][na].apply(r[ma],oa);s[ma]=s[ma]||{};s[ma][na]=oa;return false;}function ba(){if(x)x=fa(c('ge')('rightCol'),l,la.getCurrentScrubber());if(y)y=fa(c('$')(c('ProfileDOMID').ABOVE_HEADER_TIMELINE),j);if(z)z=fa(c('BlueBar').getBar(),k);}function ca(){v=c('Vector').getScrollPosition();var ma=v.y+w.y,na=c('Vector').getDocumentDimensions().y-ma;if(na<i)c('TimelineScrollJankLogger').logBottomOut(o,q);}function da(){ba();if(c('ProfileTabUtils').tabHasStickyHeader(m))aa(c('TimelineComponentKeys').STICKY_HEADER,'check',[v.y]);aa(c('TimelineComponentKeys').CONTENT,'checkCurrentSectionChange');}function ea(){c('queryThenMutateDOM')(ca,da,'TimelineController/scrollListener');}function fa(ma,na,oa){if(!ma)return false;if(v.y<=0){ga(ma,na);return false;}if(oa&&c('CSS').hasClass(oa.getRoot(),'fixed_elem')){ga(ma,na);return false;}var pa=parseInt(ma.style[na],10)||0;if(v.y<pa){c('CSS').addClass(ma,'timeline_fixed');ma.style[na]=v.y+'px';}else c('CSS').removeClass(ma,'timeline_fixed');return true;}function ga(ma,na){ma.style[na]='0px';c('CSS').removeClass(ma,'timeline_fixed');}function ha(){w=c('Vector').getViewportDimensions();}function ia(){c('queryThenMutateDOM')(ha,function(){aa(c('TimelineComponentKeys').ADS,'adjustAdsToFit');aa(c('TimelineComponentKeys').STICKY_HEADER_NAV,'adjustMenuHeights');aa(c('TimelineComponentKeys').STICKY_HEADER,'check',[v.y]);},'TimelineController/resize');}function ja(event,ma){var na=c('Vector').getScrollPosition();ma=Math.min(ma,na.y);var oa=c('ge')('rightCol');if(oa){oa.style[l]=ma+'px';x=true;}la.showAboveHeaderContent(ma);z=c('UITinyViewportAction').isTinyHeight();if(z)c('BlueBar').getBar().style[k]=ma+'px';c('Arbiter').inform('reflow');}function ka(){while(t.length)t.pop().remove();c('forEachObject')(r,function(na,oa){na.reset&&na.reset();});m=null;o=null;q=null;r={};s={};u=null;n=false;y=false;if(x){var ma=c('ge')('rightCol');if(ma)ga(ma,l);}x=false;if(z){ga(c('BlueBar').getBar(),k);z=false;}c('DataStore').purge(c('TimelineConstants').DS_LOADED);c('DataStore').purge(c('TimelineConstants').DS_COLUMN_HEIGHT_DIFFERENTIAL);}var la={init:function ma(na,oa,pa){if(n)return;if(c('ProfileTabUtils').isTimelineTab(oa))oa=c('ProfileTabConst').TIMELINE;n=true;o=na;q=c('randomInt')(Number.MAX_SAFE_INTEGER).toString();p=pa.relationship_type;t.push(c('Event').listen(window,'scroll',ea),c('Event').listen(window,'resize',ia));c('tidyEvent')(c('TidyArbiter').subscribe('TimelineCover/coverCollapsed',ja));c('ProfileNavRef').track();c('Run').onLeave(ka);la.registerCurrentKey(oa);var qa='#'+c('TimelineScrubberKey').WAY_BACK;if(window.location.hash===qa)var ra=c('Arbiter').subscribe(c('TimelineConstants').SECTION_FULLY_LOADED,function(){aa(c('TimelineComponentKeys').CONTENT,'navigateToSection',[c('TimelineScrubberKey').WAY_BACK]);ra.unsubscribe();});},setAdsTracking:function ma(na){aa(c('TimelineComponentKeys').ADS,'start',[na]);},showAboveHeaderContent:function ma(na){var oa=c('Vector').getScrollPosition();na=Math.min(na,oa.y);var pa=c('$')(c('ProfileDOMID').ABOVE_HEADER_TIMELINE);if(pa.firstChild){var qa=c('$')(c('ProfileDOMID').ABOVE_HEADER_TIMELINE_PLACEHOLDER);qa.style.height=pa.offsetHeight+'px';pa.style.top=na+'px';y=true;}},registerCurrentKey:function ma(na){m=na;u=na!==c('ProfileTabConst').MAP&&c('Vector').getViewportDimensions().y<h&&c('ProfileTabUtils').tabHasScrubber(na);u=u||c('BlueBar').getBar().offsetTop;aa(c('TimelineComponentKeys').ADS,'setShortMode',[u]);aa(c('TimelineComponentKeys').ADS,'updateCurrentKey',[na]);aa(c('TimelineComponentKeys').ADS,'adjustAdsToFit');aa(c('TimelineComponentKeys').COVER_NAV,'handleTabChange',[na]);aa(c('TimelineComponentKeys').SCRUBBER,'handleTabChange',[na]);aa(c('TimelineComponentKeys').ESCAPE_HATCH,'handleTabChange',[na]);aa(c('TimelineComponentKeys').STICKY_COLUMN,'adjust');aa(c('TimelineComponentKeys').STICKY_HEADER,'handleTabChange',[na]);ea();},getProfileID:function ma(){return o;},getRelationshipType:function ma(){return p;},getCurrentKey:function ma(){return m;},getCurrentScrubber:function ma(){return r[c('TimelineComponentKeys').SCRUBBER];},getCurrentStickyHeaderNav:function ma(){return r[c('TimelineComponentKeys').STICKY_HEADER_NAV];},scrubberHasLoaded:function ma(na){c('CSS').conditionClass(na.getRoot(),'fixed_elem',!u);aa(c('TimelineComponentKeys').ADS,'registerScrubber',[na]);},scrubberHasChangedState:function ma(){aa(c('TimelineComponentKeys').ADS,'adjustAdsToFit');},scrubberWasClicked:function ma(na){aa(c('TimelineComponentKeys').LOGGING,'logScrubberClick',[na]);},stickyHeaderNavWasClicked:function ma(na){aa(c('TimelineComponentKeys').LOGGING,'logStickyHeaderNavClick',[na]);},sectionHasChanged:function ma(na,oa){var pa=[na,oa];aa(c('TimelineComponentKeys').STICKY_HEADER_NAV,'updateSection',pa);aa(c('TimelineComponentKeys').SCRUBBER,'updateSection',pa);aa(c('TimelineComponentKeys').ADS,'loadAdsIfEnoughTimePassed');aa(c('TimelineComponentKeys').LOGGING,'logSectionChange',pa);},navigateToSection:function ma(na){aa(c('TimelineComponentKeys').CONTENT,'navigateToSection',[na]);},adjustStickyHeaderWidth:function ma(){aa(c('TimelineComponentKeys').STICKY_HEADER,'adjustWidth');},hideStickyHeaderNavSectionMenu:function ma(){aa(c('TimelineComponentKeys').STICKY_HEADER_NAV,'hideSectionMenu');},register:function ma(na,oa){r[na]=oa;if(s[na]){c('forEachObject')(s[na],function(pa,qa){aa(na,qa,pa);});delete s[na];}},adjustScrollingPagerBuffer:function ma(na,oa){var pa=c('DataStore').get(c('TimelineConstants').DS_COLUMN_HEIGHT_DIFFERENTIAL,oa);if(pa){var qa=c('ScrollingPager').getInstance(na);qa&&qa.setBuffer(qa.getBuffer()+Math.abs(pa));}},runOnceWhenSectionFullyLoaded:function ma(na,oa,pa){var qa=c('TimelineLegacySections').get(oa),ra=false;if(qa){var sa=c('DOMQuery').scry(qa.getNode(),'.fbTimelineCapsule');ra=sa.some(function(ua){var va=c('DataStore').get(c('TimelineConstants').DS_LOADED,ua.id);if(parseInt(va,10)>=parseInt(pa,10)){na();return true;}});}if(!ra)var ta=c('Arbiter').subscribe(c('TimelineConstants').SECTION_FULLY_LOADED,function(ua,va){if(va.scrubberKey===oa&&va.pageIndex===pa){na();ta.unsubscribe();}});}};f.exports=la;}),null);
__d('ProfileTimelineUILogger',['Banzai','ProfileTimelineUITypedLogger','TimelineController'],(function a(b,c,d,e,f,g){var h='profile_timeline_ui';function i(event,k,l){var m=c('TimelineController').getProfileID(),n=c('TimelineController').getRelationshipType();if(c('Banzai').isEnabled(h)&&!!m&&!!n)new (c('ProfileTimelineUITypedLogger'))().setEvent(event).setUIComponent(k).setProfileID(m).setRelationshipType(n).setEventMetadata(l).log();}var j={logCoverNavItemClick:function k(l){i('click','cover_nav_item',{tab_key:l});},logCoverNavMoreItemClick:function k(l){i('click','cover_nav_more_item',{tab_key:l});},logScrubberClick:function k(l){i('click','scrubber',{section_key:l});},logStickyHeaderImpression:function k(){i('view','sticky_header',{});},logStickyHeaderNavItemClick:function k(l){i('click','sticky_header_nav_item',{tab_key:l});},logStickyHeaderScrubberClick:function k(l){i('click','sticky_header_scrubber',{section_key:l});}};f.exports=j;}),null);
__d('TimelineCapsule',['csx','Arbiter','CSS','DataStore','DOM','DOMQuery','DOMScroll','Parent','TimelineConstants','TimelineLegacySections','Vector','$','queryThenMutateDOM'],(function a(b,c,d,e,f,g,h){var i=function(){var j={},k={};function l(n){c('DOMQuery').scry(n,"._3ram").forEach(function(o){var p=o.getAttribute('data-endmarker'),q=o.getAttribute('data-pageindex'),r=function t(){if(!o.parentNode)return;c('DataStore').set(c('TimelineConstants').DS_LOADED,n.id,q);c('DOM').remove(o);c('Arbiter').inform(c('TimelineConstants').SECTION_FULLY_LOADED,{scrubberKey:p,pageIndex:q,capsuleID:n.id,childCount:n.childNodes.length});};if(c('TimelineLegacySections').get(p)){r();}else var s=c('Arbiter').subscribe(c('TimelineConstants').SECTION_REGISTERED,function(t,u){if(u.scrubberKey===p){r();s.unsubscribe();}});});c('Arbiter').inform('TimelineCapsule/balanced',{capsule:n});}function m(n,o){var p=c('Parent').byAttribute(n,'data-size');if(p)if(c('CSS').hasClass(n.parentNode,'timelineReportContent')){o(n);}else o(p);}return {removeUnit:function n(o){m(o,function(p){c('DOM').remove(p);});},removeUnitWithID:function n(o){i.removeUnit(c('$')(o));},hideUnit:function n(o){m(o,function(p){c('CSS').addClass(p,'fbTimelineColumnHidden');});},undoHideUnit:function n(o,p){c('DOM').remove(c('Parent').byClass(p,'hiddenText'));m(o,function(q){c('CSS').removeClass(q,'fbTimelineColumnHidden');});},unplacehold:function n(o){var p=c('$')(o);p.style.top=null;c('CSS').removeClass(p,'visiblePlaceholder');c('CSS').removeClass(p,'placeholder');var q=c('Parent').byClass(p,'fbTimelineCapsule');delete j[q.id][o];i.balanceCapsule(q);},scrollToCapsule:function n(o){if(!k.hasOwnProperty(o.id)){var p=c('Vector').getElementPosition(o.parentNode);c('DOMScroll').scrollTo(new (c('Vector'))(c('Vector').getScrollPosition().x,p.y-c('TimelineConstants').SCROLL_TO_OFFSET,'document'));k[o.id]=true;}},loadTwoColumnUnits:function n(o,p,q){var r=c('$')(o);c('queryThenMutateDOM')(function(){var s=c('Parent').byClass(r,'fbTimelineSection');if(s&&!p){var t=c('DOMQuery').find(r,"._2t4u"),u=c('DOMQuery').find(r,"._2t4v"),v=u.offsetHeight-t.offsetHeight;c('DataStore').set(c('TimelineConstants').DS_COLUMN_HEIGHT_DIFFERENTIAL,q,v);}},l.bind(null,r));}};}();f.exports=i;}),null);
__d('TimelineSideAds',['csx','cx','AdsMouseStateStore','Animation','Arbiter','CSS','DataAttributeUtils','DOM','EgoAdsObjectSet','Event','ProfileTabUtils','StickyController','TimelineAdsConfig','TimelineComponentKeys','TimelineConstants','TimelineController','UIPagelet','UITinyViewportAction','URI','Vector','cxodecode','debounce','ge','getOrCreateDOMID','queryThenMutateDOM'],(function a(b,c,d,e,f,g,h,i){var j=75,k='data-height',l=c('AdsMouseStateStore').STATES,m=c('AdsMouseStateStore').get(),n=30000,o=0,p=false,q,r,s,t,u,v,w,x,y,z,aa=Infinity,ba=false,ca=5,da,ea,fa,ga,ha,ia,ja,ka,la,ma,na,oa=void 0,pa=void 0,qa=void 0,ra=void 0,sa=false,ta=[],ua;function va(ub,vb,wb){var xb=0;if(vb)xb+=vb.getHeight();if(!ab()&&!xb)return;ub-=xb;var yb=0;for(var zb=0;zb<wb;zb++)yb+=jb(zb);if(vb)if(ub<yb){ub+=vb.fold(yb-ub);}else if(ub>yb)ub-=vb.unfold(ub-yb);return ub;}function wa(){var ub=r.cloneNode(true);ub.id='';var vb=new (c('EgoAdsObjectSet'))(oa);vb.init(c('DOM').scry(ub,'div.ego_unit'));var wb=true;vb.forEach(function(xb){if(wb){wb=false;}else c('DOM').remove(xb);});c('CSS').addClass(ub,'fixed_elem');return ub;}function xa(){v=undefined;if(!c('ProfileTabUtils').tabHasScrubber(x)){bb(ca);eb();}else if(ga){cb(r,false);var ub=ha;ha&&c('DOM').remove(ha);ha=wa();if(ub)pb();bb(ea);eb();if(!z){var vb=c('TimelineController').getCurrentScrubber();if(vb)ob(vb.getRoot(),vb.getOffset());}z&&z.start();}else tb.adjustAdsToFit();}function ya(){if(ha){c('DOM').remove(ha);ha=null;}if(z){z.stop();z=null;}var ub=c('ProfileTabUtils').tabHasScrubber(x);c('CSS').conditionClass(r,'fixed_elem',!ga&&(ab()||ub));c('CSS').conditionClass(r,pa||"_5w67",!ub);c('CSS').conditionClass(r,qa||"_5w68",ub);}function za(ub){var vb=c('Vector').getViewportDimensions().y,wb=c('TimelineController').getCurrentScrubber(),xb=wb?wb.getOffset():c('TimelineConstants').SCRUBBER_DEFAULT_OFFSET,yb=vb-xb-j;if(wb||ab())return va(yb,wb,ub);}function ab(){return c('ProfileTabUtils').tabHasFixedAds(x);}function bb(ub){u=Math.min(ub,w.getCount());w.forEach(function(vb,wb){cb(vb,wb>=u);});cb(r,u===0);}function cb(ub,vb){c('CSS').conditionClass(ub,ra||"_53o5",vb);ub.setAttribute('aria-hidden',vb?'true':'false');}function db(ub){var vb=c('DOM').find(w.getUnit(ub),oa||"div._bef"),wb=c('DataAttributeUtils').getDataAttribute(vb,'data-ad');return JSON.parse(wb).adid;}function eb(){gb();fb();}function fb(){var ub;if(v!==undefined){ub=w.getHoldoutAdIDsForSpace(v,kb);}else ub=w.getHoldoutAdIDsForNumAds(u);if(ub)ub.forEach(hb);}function gb(){if(!ia)return;for(var ub=u-1;ub>=0;--ub){if(z&&z.isFixed()&&(ub!==0||ha&&!c('CSS').shown(ha)))continue;var vb=db(ub);if(!ia[vb])return;hb(vb);}}function hb(ub){if(!ia[ub])return;var vb=c('DOM').create('iframe',{src:new (c('URI'))('/ai.php').addQueryData({aed:ia[ub]}),width:0,height:0,frameborder:0,scrolling:'no',className:'fbEmuTracking'});vb.setAttribute('aria-hidden','true');c('DOM').appendContent(r,vb);delete ia[ub];}function ib(ub){var vb=0;for(var wb=0;wb<ca;wb++){var xb=jb(wb);ub-=xb;if(ub>0&&xb>0)vb++;}return vb;}function jb(ub){var vb=w.getUnit(ub);if(!vb)return 0;return kb(vb);}function kb(ub){if(!ub.getAttribute(k))lb(ub);return parseInt(ub.getAttribute(k),10);}function lb(ub){ub.setAttribute(k,ub.offsetHeight);}function mb(){for(var ub=0;ub<w.getCount();ub++){var vb=w.getUnit(ub);if(!vb)continue;lb(vb);}}function nb(){var ub=c('DOM').scry(r,'div.ego_unit');w.init(ub);var vb=ub.length;if(!vb)return;c('CSS').addClass(w.getUnit(0),'ego_unit_no_top_border');xa();setTimeout(function(){ub.forEach(lb);tb.adjustAdsToFit();aa=Date.now();},0);}function ob(ub,vb){z=new (c('StickyController'))(ub,vb,function(wb){if(wb){pb();}else{c('DOM').remove(ha);eb();}});if(ha)z.start();}function pb(){c('DOM').insertAfter(r,ha);qb();}function qb(){c('CSS').conditionShow(ha,jb(0)<=za(1)&&!c('UITinyViewportAction').isTiny());}function rb(){if(y){var ub=c('ge')(s);c('DOM').find(ub,'.ego_column').appendChild(y);}if(c('TimelineAdsConfig').fade)new (c('Animation'))(c('ge')(s)).from('opacity',0).to('opacity',1).duration(600).go();}function sb(ub){return !!c('DOM').scry(ub,'div.fbEmuHidePoll')[0];}var tb={init:function ub(vb,wb,xb){if(p)return;if(xb.nonce){var yb=xb.nonce.map(function(zb){return c('cxodecode')(zb);});oa=yb[0];pa=yb[1];qa=yb[2];ra=yb[3];}w=new (c('EgoAdsObjectSet'))(oa);ca=xb.max_ads;q=xb.refresh_delay;n=xb.refresh_threshold;da=xb.min_ads;ea=xb.min_ads_short;p=true;t=wb;r=vb;m.updateRhcID(c('getOrCreateDOMID')(r));ja=c('Arbiter').subscribe(['UFI/CommentAddedActive','UFI/CommentDeletedActive','UFI/LikeActive','Curation/Action','ProfileBrowser/LoadMoreContent','Ads/NewContentDisplayed'],tb.loadAdsIfEnoughTimePassed);ka=c('Arbiter').subscribe('TimelineSideAds/refresh',tb.forceReloadAds);la=c('Arbiter').subscribe('ProfileQuestionAnswered',tb.forceReloadAdsWithCallback);ma=c('Arbiter').subscribe('Ads/displayPoll',tb.displayAdsPoll);na=c('Arbiter').subscribe('Ads/hidePoll',tb.hideAdsPoll);ua=c('debounce')(tb.loadAdsIfEnoughTimePassed,q,this,true);if(xb.mouse_move){ta.push(c('Event').listen(window,'mousemove',ua));ta.push(c('Event').listen(window,'scroll',ua));ta.push(c('Event').listen(window,'resize',ua));ta.push(c('Event').listen(r,'mouseenter',function(){ba=true;}));ta.push(c('Event').listen(r,'mouseleave',function(){ba=false;}));}c('TimelineController').register(c('TimelineComponentKeys').ADS,tb);},setShortMode:function ub(vb){ga=vb;},start:function ub(vb){ia=vb;fa=null;nb();},updateCurrentKey:function ub(vb){if(vb==x)return;x=vb;ya();},loadAds:function ub(vb){if(fa)return;aa=Infinity;fa=c('UIPagelet').loadFromEndpoint('WebEgoPane',r.id,{pid:33,data:[t,'timeline_'+vb,ga?ea:ca,++o,false]},{crossPage:true,bundle:false,handler:rb});},registerScrubber:function ub(vb){if(ga)ob(vb.getRoot(),vb.getOffset());!fa&&tb.adjustAdsToFit();},intentShown:function ub(){if(!c('TimelineAdsConfig').stateRefresh)return false;switch(m.getState()){case l.HOVER:case l.INTENT:default:return true;case l.NO_INTENT:return false;case l.STATIONARY:return !c('TimelineAdsConfig').refreshOnStationary;}},loadAdsIfEnoughTimePassed:function ub(){if(n&&Date.now()-aa>=n&&!c('UITinyViewportAction').isTiny()&&(!z||z.isFixed())&&(!ia||!ia[db(0)])&&!tb.intentShown()&&!ba)tb.loadAds(x);tb.adjustAdsToFit();},forceReloadAdsWithCallback:function ub(vb,wb){y=wb;s=c('getOrCreateDOMID')(r);tb.loadAds(x);},forceReloadAds:function ub(){tb.loadAds(x);},displayAdsPoll:function ub(){var vb=-1;for(var wb=0;wb<w.getCount();wb++){var xb=w.getUnit(wb);if(!xb)continue;if(vb===-1&&sb(xb))vb=wb;lb(xb);}tb.adjustAdsToFit();if(vb===u&&vb>0){cb(w.getUnit(vb-1),true);cb(w.getUnit(vb),false);}},hideAdsPoll:function ub(){mb();tb.adjustAdsToFit();},adjustAdsToFit:function ub(){if(!r||sa)return;sa=true;if(ga){if(z&&ha){z.handleScroll();if(z.isFixed()){c('CSS').conditionShow(ha,jb(0)<=za(1)&&!c('UITinyViewportAction').isTiny());}else bb(ea);eb();}sa=false;return;}var vb=0;c('queryThenMutateDOM')(function(){var wb=za(da);if(wb!==undefined){v=wb;vb=ib(wb);}},function(){if(vb>0){bb(vb);eb();sa=false;}});},reset:function ub(){z&&z.stop();fa&&fa.cancel();w=new (c('EgoAdsObjectSet'))(oa);r=null;z=null;fa=null;o=0;ga=null;ha=null;x=null;aa=Infinity;p=false;ja&&c('Arbiter').unsubscribe(ja);ja=null;ka&&c('Arbiter').unsubscribe(ka);ka=null;la&&c('Arbiter').unsubscribe(la);ma&&c('Arbiter').unsubscribe(ma);na&&c('Arbiter').unsubscribe(na);la=null;ba=false;ta.forEach(function(vb){vb.remove();});ta=[];ua&&ua.reset();}};f.exports=b.TimelineSideAds||tb;}),null);
__d('TimelineStickyHeader',['Animation','Arbiter','BlueBar','Bootloader','CSS','DOM','ProfileTabConst','ProfileTabUtils','ProfileTimelineUILogger','Style','TimelineComponentKeys','TimelineController','Vector','ViewportBounds','UITinyViewportAction','ge','getOrCreateDOMID','queryThenMutateDOM'],(function a(b,c,d,e,f,g){var h=200,i=358,j=48,k=false,l=false,m,n,o,p,q=false,r=0,s,t,u={},v={VISIBLE:'TimelineStickyHeader/visible',ADJUST_WIDTH:'TimelineStickyHeader/adjustWidth',init:function w(x){if(k)return;k=true;m=x;n=c('DOM').find(x,'div.name');o=c('DOM').find(x,'div.actions');l=c('CSS').hasClass(x,'fbTimelineStickyHeaderVisible');var y,z=false,aa=true;c('queryThenMutateDOM')(function(){var ba=c('BlueBar').getBar();if(ba.offsetTop&&!c('ge')('page_admin_panel')&&c('TimelineController').getCurrentKey()!==c('ProfileTabConst').TIMELINE){y=c('Vector').tElementDimensions(ba).y;z=true;}aa=c('BlueBar').hasFixedBlueBar();},function(){if(z){c('Bootloader').loadModules(["StickyController"],function(ba){new ba(x,y).start();},'TimelineStickyHeader');}else c('CSS').addClass(x,'fixed_elem');if(!aa)c('CSS').addClass(x,'fbTimelineStickyHeaderNonFixedBlueBar');v.updateBounds(l);c('TimelineController').register(c('TimelineComponentKeys').STICKY_HEADER,v);},'TimelineStickyHeader/init');},reset:function w(){k=false;l=false;m=null;n=null;o=null;u={};p.remove();p=null;},handleTabChange:function w(x){r=c('ProfileTabUtils').isTimelineTab(x)?i-j:0;if(!c('ProfileTabUtils').tabHasStickyHeader(x)){this.toggle(false,function(){return c('CSS').hide(m);});return;}c('CSS').show(m);},updateBounds:function w(){c('queryThenMutateDOM')(function(){s=m.offsetTop;t=m.scrollHeight;},function(){p=c('ViewportBounds').addTop(function(){return l?s+t:0;});},'TimelineStickyHeader/init');},check:function w(x){if(c('UITinyViewportAction').isTiny()){this.toggle(false);return;}var y=r===0||x>=r;this.toggle(y);},toggle:function w(x,y){if(x===l){y&&y();return;}var z=x?s-t:s,aa=x?s:s-t;c('Style').set(m,'top',z+'px');c('CSS').addClass(m,'fbTimelineStickyHeaderAnimating');var ba=c('getOrCreateDOMID')(m);u[ba]&&u[ba].stop();u[ba]=new (c('Animation'))(m).from('top',z).to('top',aa).duration(h).ondone(function(){u[ba]=null;if(x&&!q){c('ProfileTimelineUILogger').logStickyHeaderImpression();q=true;}c('queryThenMutateDOM')(null,function(){c('CSS').conditionClass(m,'fbTimelineStickyHeaderHidden',!x);m.setAttribute('aria-hidden',x?'false':'true');c('CSS').removeClass(m,'fbTimelineStickyHeaderAnimating');c('Style').set(m,'top','');v.updateBounds();c('Arbiter').inform(v.VISIBLE,x);y&&y();});}).go();l=x;if(l)v.adjustWidth();},adjustWidth:function w(){c('Arbiter').inform(v.ADJUST_WIDTH,n,c('Arbiter').BEHAVIOR_STATE);},getRoot:function w(){return m;},setActions:function w(x){if(k&&x){c('DOM').setContent(o,x);o=x;}}};f.exports=b.TimelineStickyHeader||v;}),null);
__d('ButtonGroup',['CSS','DataStore','Parent'],(function a(b,c,d,e,f,g){var h='firstItem',i='lastItem';function j(o,p){var q=c('Parent').byClass(o,p);if(!q)throw new Error('invalid use case');return q;}function k(o){return c('CSS').shown(o)&&Array.from(o.childNodes).some(c('CSS').shown);}function l(o){var p,q,r;Array.from(o.childNodes).forEach(function(s){r=k(s);c('CSS').removeClass(s,h);c('CSS').removeClass(s,i);c('CSS').conditionShow(s,r);if(r){p=p||s;q=s;}});p&&c('CSS').addClass(p,h);q&&c('CSS').addClass(q,i);c('CSS').conditionShow(o,p);}function m(o,p){var q=j(p,'uiButtonGroupItem');o(q);l(q.parentNode);}function n(o){'use strict';this._root=j(o,'uiButtonGroup');c('DataStore').set(this._root,'ButtonGroup',this);l(this._root);}n.getInstance=function(o){'use strict';var p=j(o,'uiButtonGroup'),q=c('DataStore').get(p,'ButtonGroup');return q||new n(p);};Object.assign(n.prototype,{hideItem:m.bind(null,c('CSS').hide),showItem:m.bind(null,c('CSS').show),toggleItem:m.bind(null,c('CSS').toggle)});f.exports=n;}),null);
__d('TimelineStickyHeaderNav',['Arbiter','BlueBar','ButtonGroup','CSS','DataStore','DateStrings','DOM','Event','Parent','ProfileTimelineUILogger','SelectorDeprecated','Style','SubscriptionsHandler','TimelineComponentKeys','TimelineConstants','TimelineController','UITinyViewportAction','URI','Vector','queryThenMutateDOM'],(function a(b,c,d,e,f,g){var h=false,i,j,k,l,m,n,o,p,q,r,s,t={},u={},v=[],w=false,x=[],y=[],z,aa=80;function ba(){var na=c('SelectorDeprecated').getSelectorMenu(m);z.addSubscriptions(c('Event').listen(na,'click',ca),c('Arbiter').subscribe(c('TimelineConstants').SECTION_REGISTERED,ea));}function ca(event){var na=c('Parent').byTag(event.getTarget(),'a'),oa=na&&c('DataStore').get(na,'key');if(oa){c('TimelineController').stickyHeaderNavWasClicked(oa);c('TimelineController').navigateToSection(oa);c('ProfileTimelineUILogger').logStickyHeaderScrubberClick(oa);event.prevent();}}function da(na){if(r===na&&p[na]&&!j.custom_subsection_menu){ia(na);}else fa();c('TimelineController').adjustStickyHeaderWidth();}function ea(na,oa){var pa=oa.section,qa=pa&&pa.getParentKey();if(!qa)return;var ra=ha(qa),sa=c('TimelineController').getCurrentScrubber(),ta=pa.getScrubberKey(),ua=sa?sa.getLabelForSubnav(qa,ta):ua=ga(ta);if(ua){p[qa]=true;ja(ra,{key:ta,label:ua});da(qa);}}function fa(){if(k)k.hideItem(n);}function ga(na){var oa=na.split('_');return c('DateStrings').getMonthName(parseInt(oa.pop(),10));}function ha(na){var oa=o[na];if(!oa){oa=o[na]=n.cloneNode(true);var pa=c('DOM').scry(oa,'li.activityLog a')[0];if(pa)pa.href=new (c('URI'))(pa.href).addQueryData({key:na});z.addSubscriptions(c('Event').listen(oa,'click',ca));}return oa;}function ia(na){var oa=ha(na);c('DOM').insertAfter(n,oa);c('CSS').hide(n);for(var pa in o){var qa=o[pa];c('CSS').conditionShow(qa,qa===oa);}if(k)k.showItem(n);}function ja(na,oa){var pa=c('DOM').create('a',{href:'#',rel:'ignore',className:'itemAnchor',tabIndex:0},c('DOM').create('span',{className:'itemLabel fsm'},oa.label));pa.setAttribute('data-key',oa.key);pa.setAttribute('aria-checked',false);var qa=c('DOM').create('li',{className:'uiMenuItem uiMenuItemRadio uiSelectorOption'},pa);qa.setAttribute('data-label',oa.label);var ra=c('DOM').find(na,'ul.uiMenuInner'),sa=c('DOM').create('option',{value:oa.key},oa.label),ta=c('DOM').find(na,'select');if(oa.key==='recent'){c('DOM').prependContent(ra,qa);c('DOM').insertAfter(ta.options[0],sa);}else{c('DOM').appendContent(ra,qa);c('DOM').appendContent(ta,sa);}}function ka(na,oa){var pa=c('DOM').scry(na,'li.uiMenuItem');if(!pa)return;for(var qa=0;qa<pa.length;qa++){var ra=pa[qa];if(c('CSS').hasClass(ra,oa)||ra.firstChild.getAttribute('data-key')==oa){c('DOM').remove(ra);break;}}var sa=c('DOM').find(na,'select'),ta=c('DOM').scry(sa,'option');for(qa=0;qa<ta.length;qa++)if(ta[qa].value===oa){c('DOM').remove(ta[qa]);return;}}function la(event){var na=c('Parent').byClass(event.target,'itemAnchor');if(na){var oa=c('DataStore').get(na,'tab-key');if(oa)c('ProfileTimelineUILogger').logStickyHeaderNavItemClick(oa);}}var ma={init:function na(oa,pa){if(h)return;h=true;i=oa;j=pa||{};l=c('DOM').find(i,'div.pageMenu');m=c('DOM').find(i,'div.sectionMenu');n=c('DOM').find(i,'div.subsectionMenu');s=c('DOM').find(l,'li.uiMenuSeparator');k=c('ButtonGroup').getInstance(l);z=new (c('SubscriptionsHandler'))();o={};p={};q={};ma.adjustMenuHeights();ba();c('TimelineController').register(c('TimelineComponentKeys').STICKY_HEADER_NAV,ma);y.forEach(function(qa){qa();});z.addSubscriptions(c('Event').listen(l,'click',la));},reset:function na(){h=false;j={};v=[];t={};u={};w=false;x=[];i=null;l=null;m=null;n=null;s=null;o={};p={};q={};z.release();},addTimePeriod:function na(oa){var pa=c('TimelineController').getCurrentScrubber();if(!pa)return;var qa=pa.getLabelForNav(oa);if(!qa)return;ja(m,{key:oa,label:qa});var ra=c('DOM').find(m,'ul.uiMenuInner');if(oa==='recent'||ra.children.length<2)c('SelectorDeprecated').setSelected(m,oa,true);},updateSection:function na(oa,pa){if(pa){var qa=ha(oa);c('SelectorDeprecated').setSelected(qa,pa);}else q[oa]=true;r=oa;c('SelectorDeprecated').setSelected(m,oa,true);da(oa);},adjustMenuHeights:function na(){var oa='';c('queryThenMutateDOM')(function(){if(!c('UITinyViewportAction').isTiny()){oa=c('Vector').getViewportDimensions().y-c('Vector').getElementDimensions(c('BlueBar').getBar()).y-aa;oa+='px';}},function(){[l,m].map(function(pa){if(pa)c('Style').set(c('DOM').find(pa,'ul.uiMenuInner'),'maxHeight',oa);});});},initPageMenu:function na(oa,pa){if(!h){y.push(ma.initPageMenu.bind(null,oa,pa));return;}function qa(ra,sa){ra.forEach(function(ta){var ua=u[ta]=c('DOM').create('li');c('CSS').hide(ua);sa?c('DOM').insertBefore(s,ua):c('DOM').appendContent(c('DOM').find(l,'ul.uiMenuInner'),ua);});}qa(oa,true);qa(pa,false);t.info=c('DOM').scry(l,'li')[0];v=pa;w=true;if(x.length)x.forEach(function(ra){ma.registerPageMenuItem(ra.key,ra.item);});},registerPageMenuItem:function na(oa,pa){if(!w){x.push({key:oa,item:pa});return;}if(u[oa]){c('DOM').replace(u[oa],pa);t[oa]=pa;delete u[oa];if(v.indexOf(oa)>=0)c('CSS').show(s);}},removeTimePeriod:function na(oa){ka(m,oa);},hideSectionMenu:function na(){if(h)c('CSS').hide(m);}};f.exports=ma;}),null);
__d('legacy:ui-scrolling-pager-js',['ScrollingPager'],(function a(b,c,d,e,f,g){b.ScrollingPager=c('ScrollingPager');}),3);
__d('ButtonGroupMonitor',['ContextualDialog','ContextualLayer','CSS','Layer','Parent','SelectorDeprecated','DataStore'],(function a(b,c,d,e,f,g){function h(i,j){var k=c('Parent').byClass(i,'bg_stat_elem')||c('Parent').byClass(i,'uiButtonGroup');if(!k&&j)k=c('DataStore').get(j,'toggleElement',null);if(k){j&&c('DataStore').set(j,'toggleElement',k);c('CSS').toggleClass(k,'uiButtonGroupActive');}}c('Layer').subscribe(['hide','show'],function(i,j){if(j instanceof c('ContextualLayer')||j instanceof c('ContextualDialog'))h(j.getCausalElement(),j);});c('SelectorDeprecated').subscribe(['close','open'],function(i,j){h(j.selector);});}),null);