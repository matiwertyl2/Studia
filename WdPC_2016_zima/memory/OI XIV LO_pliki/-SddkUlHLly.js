if (self.CavalryLogger) { CavalryLogger.start_js(["cOBdP"]); }

__d("OzConstants",[],(function a(b,c,d,e,f,g){f.exports={AUTHOR_TYPES:{BOT:"bot",TRAINER:"trainer",USER:"user"},ATTS:{COMMAND:"\u0040COMMAND",IMAGE:"image",SUGG:"\u0040SUGG",TEMPLATE:"template",SURVEY:"survey",QUICK_REPLIES:"\u0040QUICK_REPLIES",OPENTABLEQR:"opentableQuickReply"},SESSION_INFO_EVENT:"iframenonce_fb_session_info",TOKENS:{USER_FIRST_NAME:"user-first-name"},REMINDERS:{RANGE_IN_YEARS:5},M_FBIDS:{M:"881263441913087",M_DEV:"1579802578966277",P:"506060876211905"}};}),null);
__d('ChatTabPolicy',['ChatBehavior','JSLogger','MercuryActionType','MercuryLogMessageType','MercuryAssert','MercuryBlockedParticipants','MercuryConfig','MercuryGroupThreadMentions','MercuryIDs','MercuryParticipantTypes','MercurySourceType','MercuryThreadActions','MercuryThreadInfo','MercuryViewer','MessagingTag','OzConstants','PresencePrivacy','Set','ShortProfiles','WorkModeConfig','isInFocusMode'],(function a(b,c,d,e,f,g){var h=c('MercuryBlockedParticipants').get(),i=c('MercuryThreadActions').get(),j=c('OzConstants').M_FBIDS,k=j.M_DEV,l=j.M,m=j.P,n=new (c('Set'))([k,l,m]),o=c('JSLogger').create('tab_policy');f.exports={messageIsAllowed:function p(q,r,s){var t=q.thread_id,u=r.message_id;c('MercuryAssert').isThreadID(t);c('MercuryAssert').isParticipantID(r.author);var v;if(c('MercuryThreadInfo').isMuted(q)){v={thread_id:t,message_id:u,mute_until:q.mute_until};o.log('message_thread_muted',v);if(c('MercuryConfig').GroupChatMentionsGK)c('MercuryGroupThreadMentions').messageMentionsViewer(r,function(y){if(y)s();});return;}if(c('isInFocusMode')(t)){v={thread_id:t,message_id:u,availability_mode:'focus'};o.log('message_thread_focus_mode',v);return;}if(q.read_only){v={thread_id:t,message_id:u,mode:q.mode};o.log('message_read_only',v);return;}if(r.source==c('MercurySourceType').EMAIL||r.source==c('MercurySourceType').TITAN_EMAIL_REPLY){v={thread_id:t,message_id:u,source:r.source};o.log('message_source_not_allowed',v);return;}var w=c('MercuryIDs').getUserIDFromParticipantID(r.author);if(!w){o.log('message_bad_author',{thread_id:t,message_id:u,user:w});return;}if(r.action_type!=c('MercuryActionType').USER_GENERATED_MESSAGE&&!this._messageIsNewlyCreatedGroup(r,q)){v={thread_id:t,message_id:u,type:r.action_type};o.log('message_non_user_generated',v);return;}if(q.is_canonical_user&&!c('ChatBehavior').notifiesUserMessages()){o.log('message_jabber',{thread_id:t,message_id:u});i.markSeen(t,true);return;}if(q.is_canonical&&!q.other_user_fbid){o.log('message_canonical_contact',{thread_id:t,message_id:u});return;}if(q.folder!=c('MessagingTag').INBOX){o.log('message_folder',{thread_id:t,message_id:u,folder:q.folder});return;}if(h.isPresentInGroupThread(q)){v={thread_id:t,message_id:u};o.log('message_blocked_participants',v);return;}var x=c('MercuryIDs').getUserIDFromParticipantID(c('MercuryViewer').getID());c('ShortProfiles').getMulti([w,x],function(y){if(!c('PresencePrivacy').allows(w)){o.log('message_privacy',{thread_id:t,message_id:u,user:w});return;}var z=y[w].employee&&y[x].employee,aa=c('WorkModeConfig').is_work_user;if(!z&&!aa&&!y[w].isCommercePage&&!n.has(w)&&y[w].type!==c('MercuryParticipantTypes').FRIEND&&y[w].type!==c('MercuryParticipantTypes').PAGE){o.log('message_non_friend',{thread_id:t,message_id:u,user:w});return;}s();});},_messageIsNewlyCreatedGroup:function p(q,r){return q.action_type===c('MercuryActionType').LOG_MESSAGE&&q.log_message_type===c('MercuryLogMessageType').THREAD_NAME&&r.message_count===1;}};}),null);