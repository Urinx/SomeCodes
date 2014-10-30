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

require(['app'],function(app){
    app.build();
    // Add drag and move feature
    app.enableDrag('todolist');
    // wechat share
    app.wechatShare('To-do list','blablabla...');
});