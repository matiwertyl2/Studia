if (self.CavalryLogger) { CavalryLogger.start_js(["D+lWU"]); }

__d('FlexibleBlock.react',['cx','invariant','LeftRight.react','React','keyMirror'],(function a(b,c,d,e,f,g,h,i){var j,k,l=c('keyMirror')({left:true,right:true});function m(o){o.flex&&o.flex in n.FLEX||i(0);o.children&&o.children.length===2||i(0);}j=babelHelpers.inherits(n,c('React').Component);k=j&&j.prototype;n.prototype.render=function(){'use strict';m(this.props);var o,p=this.props.children[0],q=this.props.children[1],r=this.props.flex==l.left,s;if(r){s=p;o=c('LeftRight.react').DIRECTION.right;}else{s=q;o=c('LeftRight.react').DIRECTION.left;}var t=c('React').createElement('div',{className:"_42ef"},s);return (c('React').createElement(c('LeftRight.react'),babelHelpers['extends']({},this.props,{direction:o}),r?t:this.props.children[0],r?this.props.children[1]:t));};function n(){'use strict';j.apply(this,arguments);}n.FLEX=l;f.exports=n;}),null);
__d('GamesDesktopDownloadStep.react',['ix','cx','FlexibleBlock.react','Image.react','React','XUICard.react','XUIText.react','fbglyph'],(function a(b,c,d,e,f,g,h,i){'use strict';var j,k;j=babelHelpers.inherits(l,c('React').Component);k=j&&j.prototype;function l(m){k.constructor.call(this,m);this.$GamesDesktopDownloadStep1=function(){this.setState({collapsed:!this.state.collapsed});}.bind(this);this.state={collapsed:true};}l.prototype.render=function(){var m="_3-8y _2pi1 _52ju _aqw";return c('React').createElement(c('XUICard.react'),{className:m,onClick:this.$GamesDesktopDownloadStep1},c('React').createElement(c('FlexibleBlock.react'),{flex:c('FlexibleBlock.react').FLEX.left},c('React').createElement(c('XUIText.react'),{size:'medium'},this.props.title),c('React').createElement(c('Image.react'),{onClick:this.$GamesDesktopDownloadStep1,role:'button',src:h("images\/assets_DO_NOT_HARDCODE\/fb_glyphs\/chevron-down_20_fig-light-50.png"),tabIndex:'0'})),c('React').createElement('div',{className:"_aqx"+(!this.state.collapsed?' '+"_aqy":'')},this.props.children));};f.exports=l;}),null);
__d('GameroomDownloadInstructionsDialog.react',['ix','cx','fbt','DTSG','GamesDesktopDownloadStep.react','GamesDesktopIntructionsDialogFeature','Image.react','LeftRight.react','Link.react','QE2Logger','React','ReactDOM','URI','XUICloseButton.react','XUIDialog.react','XUIDialogBody.react','XUIText.react','fbglyph'],(function a(b,c,d,e,f,g,h,i,j){'use strict';var k,l,m=700,n=164,o='/images/games/desktop-app/arrow.gif',p='/images/appcenter/icons/downloadGamesDesktopApp.png',q='/images/games/desktop-app/gamesLogo.svg',r='/help/1742517309347170',s='https://www.facebook.com/terms.php/',t='https://www.facebook.com/full_data_use_policy/';k=babelHelpers.inherits(u,c('React').PureComponent);l=k&&k.prototype;u.prototype.componentWillReceiveProps=function(x){if(this.props.dialogShown)c('QE2Logger').logExposureForUser('gameroom_new_instructions_dialog_universe');};u.prototype.render=function(){var x=this.props.downloadURI,y=j._("Zamknij"),z=c('React').createElement(c('Link.react'),{href:!this.props.isPostDownload?x:undefined,onClick:function(){if(this.$GameroomDownloadInstructionsDialog1&&this.$GameroomDownloadInstructionsDialog1.submit)c('ReactDOM').findDOMNode(this.$GameroomDownloadInstructionsDialog1).submit();}.bind(this)},j._("kliknij tutaj, aby spr\u00f3bowa\u0107 ponownie")),aa=this.props.isPostDownload?c('React').createElement('form',{action:x,className:"_4opz",method:'post',ref:function(ca){return this.$GameroomDownloadInstructionsDialog1=ca;}.bind(this)},c('React').createElement('input',{name:'fb_dtsg',type:'hidden',value:c('DTSG').getToken()}),z):z,ba=j._("Je\u017celi pobieranie nie zostanie rozpocz\u0119te, {click here to try again}.",[j.param('click here to try again',aa)]);return (c('React').createElement(c('XUIDialog.react'),{className:"_151v",onToggle:this.props.onToggle,shown:this.props.dialogShown,width:m},this.props.showBlinkyArrow?c('React').createElement(v,null):null,c('React').createElement(c('XUIDialogBody.react'),null,c('React').createElement(c('XUICloseButton.react'),{className:"_151o",onClick:this.props.onCloseClick,shade:'dark',title:y},y),c('GamesDesktopIntructionsDialogFeature').is_enabled?this.$GameroomDownloadInstructionsDialog2():c('React').createElement('frag',null,c('React').createElement(c('Image.react'),{src:p}),c('React').createElement('div',{className:"_151r"},j._("Dzi\u0119kujemy za pobranie aplikacji Facebook Gameroom"))),c('GamesDesktopIntructionsDialogFeature').is_enabled?c('React').createElement('frag',null,c('React').createElement('div',{className:"_5zks"},c('React').createElement(c('Image.react'),{className:"_-a9",src:h("images\/assets_DO_NOT_HARDCODE\/fb_glyphs\/info-solid_20_white.png")}),c('React').createElement('frag',{className:"_-aa"},ba))):c('React').createElement('div',{className:"_151u"},c('React').createElement('div',null,j._("Kliknij plik {FacebookGameroomSetup.exe}, aby zainstalowa\u0107.",[j.param('FacebookGameroomSetup.exe',c('React').createElement('strong',null,'FacebookGameroom.exe'))])),c('React').createElement('div',null,ba)),c('React').createElement(w,null))));};u.prototype.$GameroomDownloadInstructionsDialog2=function(){return (c('React').createElement('div',{className:"_jsv"},c('React').createElement(c('LeftRight.react'),null,c('React').createElement(c('Image.react'),{height:44,src:q,width:44}),c('React').createElement('div',{className:"_jsw"},c('React').createElement(c('XUIText.react'),{display:'block',size:'medium',weight:'bold'},j._("Graj w swoje gry w Gameroom")),j._("Pobieranie rozpocznie si\u0119 wkr\u00f3tce. Nast\u0119pnie, wykonaj te kroki, aby uruchomi\u0107 Gameroom. Po uko\u0144czeniu pobierania i instalacji mo\u017cesz gra\u0107 w gry w Gameroom."))),c('React').createElement('div',null,c('React').createElement(c('GamesDesktopDownloadStep.react'),{title:j._("Wyszukaj plik {FacebookGameroom.exe}",[j.param('FacebookGameroom.exe',c('React').createElement('strong',null,'FacebookGameroom.exe'))])},j._("Plik b\u0119dzie dost\u0119pny w folderze pobierania.")),c('React').createElement(c('GamesDesktopDownloadStep.react'),{title:j._("Otw\u00f3rz {FacebookGameroom.exe}",[j.param('FacebookGameroom.exe',c('React').createElement('strong',null,'FacebookGameroom.exe'))])},j._("Po otwarciu pliku nast\u0105pi automatyczne pobieranie i instalowanie aplikacji Gameroom.")),c('React').createElement(c('GamesDesktopDownloadStep.react'),{title:j._("Zainstaluj Gameroom, odkrywaj gry i graj w nie.")},j._("Graj, ogl\u0105daj i udost\u0119pniaj gry w Gameroom.")))));};function u(){k.apply(this,arguments);}var v=function x(){return (c('React').createElement('div',{className:"_16a2"},c('React').createElement('div',{className:"_16a3"},j._("Kliknij, aby zainstalowa\u0107")),c('React').createElement(c('Image.react'),{height:n,src:o,width:n})));},w=function x(){return (c('React').createElement('div',{className:"_tio"},j._("Instaluj\u0105c aplikacj\u0119, akceptujesz {Terms} i {Privacy Policy}. Instalacja aplikacji Gameroom mo\u017ce r\u00f3wnie\u017c wi\u0105za\u0107 si\u0119 z konieczno\u015bci\u0105 instalacji aplikacji Adobe Flash Player, umo\u017cliwiaj\u0105cej prawid\u0142owe dzia\u0142anie wielu gier. Aktualizacja aplikacji Gameroom i Adobe Flash Player zostanie wykonana automatycznie. Mo\u017cesz w dowolnej chwili odinstalowa\u0107 te aplikacje. {Learn More}.",[j.param('Terms',c('React').createElement(c('Link.react'),{href:new (c('URI'))(s),target:'_blank',type:'subtle'},'Terms')),j.param('Privacy Policy',c('React').createElement(c('Link.react'),{href:new (c('URI'))(t),target:'_blank',type:'subtle'},'Privacy Policy')),j.param('Learn More',c('React').createElement(c('Link.react'),{href:new (c('URI'))(r),target:'_blank',type:'subtle'},'Learn more'))])));};f.exports=u;}),null);
__d("XGameroomLandingPageController",["XController"],(function a(b,c,d,e,f,g){f.exports=c("XController").create("\/gameroom\/",{app_id:{type:"FBID"},at:{type:"String"},video_id:{type:"FBID"}});}),null);
__d("XGamesDesktopAppDownloadController",["XController"],(function a(b,c,d,e,f,g){f.exports=c("XController").create("\/games\/desktopapp\/download\/",{app_id:{type:"Int"},fbsource:{type:"Int"},ref:{type:"String"},video_id:{type:"Int"}});}),null);
__d("XGamesDesktopAppDownloadWithNotificationController",["XController"],(function a(b,c,d,e,f,g){f.exports=c("XController").create("\/games\/desktopapp\/download_with_notification\/",{app_id:{type:"Int"},fbsource:{type:"Int"},ref:{type:"String"},video_id:{type:"Int"}});}),null);
__d('GameroomDownloadButton.react',['ix','cx','fbt','DTSG','GameroomDownloadInstructionsDialog.react','Image.react','React','XGameroomLandingPageController','XGamesDesktopAppDownloadController','XGamesDesktopAppDownloadWithNotificationController','XUIButton.react','fbglyph'],(function a(b,c,d,e,f,g,h,i,j){'use strict';var k,l;k=babelHelpers.inherits(m,c('React').PureComponent);l=k&&k.prototype;function m(){l.constructor.call(this);this.state={dialogShown:false};}m.prototype.render=function(){var o=this.props.appID,p=this.props.referral,q=this.props.redirectLandingPage,r;if(q){var s=c('XGameroomLandingPageController').getURIBuilder();if(this.props.appID)s.setFBID('app_id',o);if(p)s.setString('at',p);r=s.getURI().setDomain('www.facebook.com').setProtocol('https');}else{var t=this.props.isLoggedInUser?c('XGamesDesktopAppDownloadWithNotificationController').getURIBuilder():c('XGamesDesktopAppDownloadController').getURIBuilder();t.setInt('app_id',this.props.appID).setInt('fbsource',this.props.fbsource).setInt('video_id',this.props.videoID);if(p)t.setString('ref',p);r=t.getURI();}var u=!q&&this.props.isLoggedInUser,v=c('React').createElement(c('XUIButton.react'),{className:"_1y7f"+(' '+"_1siq")+(!this.props.canDownload?' '+"_30ik":''),disabled:!this.props.canDownload,href:!u?r:undefined,label:c('React').createElement(n,{cta:this.props.cta,useFreeDownloadText:this.props.useFreeDownloadText}),onClick:function(){return this.setState({dialogShown:true});}.bind(this),size:this.props.size,target:q?'_blank':'',use:'confirm'}),w=u?c('React').createElement('form',{action:r,method:'post'},c('React').createElement('input',{name:'fb_dtsg',type:'hidden',value:c('DTSG').getToken()}),v):v;return (c('React').createElement('div',null,!this.props.redirectLandingPage?c('React').createElement(c('GameroomDownloadInstructionsDialog.react'),{appID:this.props.appID,dialogShown:this.state.dialogShown,downloadURI:r,fbsource:this.props.fbsource,isPostDownload:u,onCloseClick:function(){return this.setState({dialogShown:false});}.bind(this),onToggle:function(x){return this.setState({dialogShown:x});}.bind(this),showBlinkyArrow:this.props.showBlinkyArrow}):null,w));};m.defaultProps={redirectLandingPage:true,useFreeDownloadText:false};var n=function o(p){return (c('React').createElement('span',{className:"_2k_9"},c('React').createElement(c('Image.react'),{className:"_2k_a",src:h("images\/assets_DO_NOT_HARDCODE\/fb_glyphs\/download_20_white.png")}),c('React').createElement('span',null,!p.useFreeDownloadText?p.cta:j._("Darmowa instalacja"))));};f.exports=m;}),null);