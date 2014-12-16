~function (global) {

    // status
    var PENDING = 0,
        FULFILLED = 1,
        REJECTED = 2;

    var Promise = function (fun) {
            var me = this,
                resolve = function (val) {
                    me.resolve(val);
                },
                reject = function (val) {
                    me.reject(val);
                };
            me._status = PENDING;
            me._onFulfilled = null;
            me._onRejected = null;
            (typeof fun === 'function') && fun(resolve, reject);
        };

    var fn = Promise.prototype;

    fn.then = function (resolve, reject) {
        var pms = new Promise();
        this._onFulfilled = function (val) {
            var ret = resolve ? resolve(val) : val;
            if (Promise.isPromise(ret)) {
                ret.then(function (val) {
                    pms.resolve(val);
                });
            }
            else{
                pms.resolve(ret);
            }
        };
        this._onRejected = function (val) {
            var ret = reject ? reject(val) : val;
            pms.reject(ret);
        };
        return pms;
    }

    fn.catch = function (reject) {
        return this.then(null, reject);
    }

    fn.resolve = function (val) {
        if (this._status === PENDING) {
            this._status = FULFILLED;
            this._onFulfilled && this._onFulfilled(val);
        }
    }

    fn.reject = function (val) {
        if (this._status === PENDING) {
            this._status = REJECTED;
            this._onRejected && this._onRejected(val);
        }
    }

    fn.all = function (arr) {
        var pms = new Promise();
        var len = arr.length,
            i = -1,
            count = 0,
            results = [];
        while (++i < len) {
            ~function (i) {
                arr[i].then(
                    function (val) {
                        results[i] = val;
                        if (++count === len) {
                            pms.resolve(results);
                        }
                    },
                    function (val) {
                        pms.reject(val);
                    }
                );
            }(i);
        }
        return pms;
    }

    fn.resolve = function (obj) {
        var ret;
        if (!Promise.isPromise(obj)) {
            ret = obj;
            obj = new Promise();
        }
        setTimeout(function () {
            obj.resolve(ret);
        });
        return obj;
    }

    fn.reject = function (obj) {
        var ret;
        if (!Promise.isPromise(obj)) {
            ret = obj;
            obj = new Promise();
        }
        setTimeout(function () {
            obj.reject(ret);
        });
        return obj;
    }

    fn.isPromise = function (obj) {
        return obj instanceof Promise;
    }


    global.Promise = Promise;

    try{
        module.exports = Promise;
    }
    catch (e){}

}(this);