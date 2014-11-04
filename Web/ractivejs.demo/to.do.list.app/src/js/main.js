require.config({
    baseUrl:'js',
    paths:{
        jquery:'libs/jquery-2.1.1.min',
        ractive:'libs/ractive',
        app:'app',
        'dragMove':'plugins/jquery/dragMove',
        tap:'plugins/ractivejs/ractive-events-tap',
        text:'plugins/requirejs/text',
        wechat:'plugins/wechat'
    },
    shim:{
        'dragMove':{
            deps: ['jquery']
        }
    }
});

require(['app','wechat'],function(app,wechat){
    app.build();
    // Add drag and move feature
    app.enableDrag('todolist');
    // wechat share
    wechat.share('我的To-do list','关注我的微信公众号Urinx，感受三体纳米科技核心智慧。',app.setWechatShareUrl);
});