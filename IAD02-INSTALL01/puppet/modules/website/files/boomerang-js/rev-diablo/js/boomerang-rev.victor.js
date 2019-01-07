function BOOMR_check_doc_domain(e) {
    var t;
    if (!e) {
        if (window.parent === window || !document.getElementById("boomr-if-as")) {
            return true
        }
        e = document.domain
    }
    if (e.indexOf(".") === -1) {
        return false
    }
    try {
        t = window.parent.document;
        return true
    } catch (n) {
        document.domain = e
    }
    try {
        t = window.parent.document;
        return true
    } catch (n) {
        e = e.replace(/^[\w-]+\./, "")
    }
    return BOOMR_check_doc_domain(e)
}

function BOOMR_in_iframe() {
    try {
        return window.self !== window.top
    } catch (e) {
        return true
    }
}
BOOMR_start = (new Date).getTime();
BOOMR_check_doc_domain();
(function(e) {
    if (BOOMR_in_iframe()) return;
    var t, n, r, i;
    if (e.parent !== e && document.getElementById("boomr-if-as") && document.getElementById("boomr-if-as").nodeName.toLowerCase() === "script") {
        e = e.parent;
        i = document.getElementById("boomr-if-as").src
    }
    r = e.document;
    if (e.BOOMR === undefined) {
        e.BOOMR = {}
    }
    BOOMR = e.BOOMR;
    if (BOOMR.version) {
        return
    }
    BOOMR.version = "0.9.1396020860";
    BOOMR.window = e;
    t = {
        beacon_url: "",
        site_domain: e.location.hostname.replace(/.*?([^.]+\.[^.]+)\.?$/, "$1").toLowerCase(),
        user_ip: "",
        strip_query_string: false,
        onloadfired: false,
        handlers_attached: false,
        events: {
            page_ready: [],
            page_unload: [],
            dom_loaded: [],
            visibility_changed: [],
            before_beacon: [],
            xhr_load: [],
            click: [],
            form_submit: []
        },
        vars: {},
        disabled_plugins: {},
        onclick_handler: function(n) {
            var r;
            if (!n) {
                n = e.event
            }
            if (n.target) {
                r = n.target
            } else if (n.srcElement) {
                r = n.srcElement
            }
            if (r.nodeType === 3) {
                r = r.parentNode
            }
            if (r && r.nodeName.toUpperCase() === "OBJECT" && r.type === "application/x-shockwave-flash") {
                return
            }
            t.fireEvent("click", r)
        },
        onsubmit_handler: function(n) {
            var r;
            if (!n) {
                n = e.event
            }
            if (n.target) {
                r = n.target
            } else if (n.srcElement) {
                r = n.srcElement
            }
            if (r.nodeType === 3) {
                r = r.parentNode
            }
            t.fireEvent("form_submit", r)
        },
        fireEvent: function(e, t) {
            var n, r, i;
            if (!this.events.hasOwnProperty(e)) {
                return false
            }
            i = this.events[e];
            for (n = 0; n < i.length; n++) {
                r = i[n];
                r[0].call(r[2], t, r[1])
            }
            return true
        }
    };
    n = {
        t_lstart: null,
        t_start: BOOMR_start,
        t_end: null,
        url: i,
        utils: {
            objectToString: function(e, t) {
                var n = [],
                    r;
                if (!e || typeof e !== "object") {
                    return e
                }
                if (t === undefined) {
                    t = "\n	"
                }
                for (r in e) {
                    if (Object.prototype.hasOwnProperty.call(e, r)) {
                        n.push(encodeURIComponent(r) + "=" + encodeURIComponent(e[r]))
                    }
                }
                return n.join(t)
            },
            getCookie: function(e) {
                if (!e) {
                    return null
                }
                e = " " + e + "=";
                var t, n;
                n = " " + r.cookie + ";";
                if ((t = n.indexOf(e)) >= 0) {
                    t += e.length;
                    n = n.substring(t, n.indexOf(";", t));
                    return n
                }
                return null
            },
            setCookie: function(e, n, i) {
                var s, o, u, a, f;
                if (!e || !t.site_domain) {
                    BOOMR.debug("No cookie name or site domain: " + e + "/" + t.site_domain);
                    return false
                }
                s = this.objectToString(n, "&");
                o = e + "=" + s;
                a = [o, "path=/", "domain=" + t.site_domain];
                if (i) {
                    f = new Date;
                    f.setTime(f.getTime() + i * 1e3);
                    f = f.toGMTString();
                    a.push("expires=" + f)
                }
                if (o.length < 500) {
                    r.cookie = a.join("; ");
                    u = this.getCookie(e);
                    if (s === u) {
                        return true
                    }
                    BOOMR.warn("Saved cookie value doesn't match what we tried to set:\n" + s + "\n" + u)
                } else {
                    BOOMR.warn("Cookie too long: " + o.length + " " + o)
                }
                return false
            },
            getSubCookies: function(e) {
                var t, n, r, i, s = false,
                    o = {};
                if (!e) {
                    return null
                }
                if (typeof e !== "string") {
                    BOOMR.debug("TypeError: cookie is not a string: " + typeof e);
                    return null
                }
                t = e.split("&");
                for (n = 0, r = t.length; n < r; n++) {
                    i = t[n].split("=");
                    if (i[0]) {
                        i.push("");
                        o[decodeURIComponent(i[0])] = decodeURIComponent(i[1]);
                        s = true
                    }
                }
                return s ? o : null
            },
            removeCookie: function(e) {
                return this.setCookie(e, {}, -86400)
            },
            cleanupURL: function(e) {
                if (t.strip_query_string) {
                    return e.replace(/\?.*/, "?qs-redacted")
                }
                return e
            },
            hashQueryString: function(e, t) {
                if (!e) {
                    return e
                }
                if (t) {
                    e = e.replace(/#.*/, "")
                }
                if (!BOOMR.utils.MD5) {
                    return e
                }
                return e.replace(/\?([^#]*)/, function(e, t) {
                    return "?" + (t.length > 10 ? BOOMR.utils.MD5(t) : t)
                })
            },
            pluginConfig: function(e, t, n, r) {
                var i, s = 0;
                if (!t || !t[n]) {
                    return false
                }
                for (i = 0; i < r.length; i++) {
                    if (t[n][r[i]] !== undefined) {
                        e[r[i]] = t[n][r[i]];
                        s++
                    }
                }
                return s > 0
            },
            addListener: function(e, t, n) {
                if (e.addEventListener) {
                    e.addEventListener(t, n, false)
                } else {
                    e.attachEvent("on" + t, n)
                }
            },
            removeListener: function(e, t, n) {
                if (e.removeEventListener) {
                    e.removeEventListener(t, n, false)
                } else {
                    e.detachEvent("on" + t, n)
                }
            }
        },
        init: function(i) {
            var s, o, u = ["beacon_url", "site_domain", "user_ip", "strip_query_string"];
            BOOMR_check_doc_domain();
            if (!i) {
                i = {}
            }
            for (s = 0; s < u.length; s++) {
                if (i[u[s]] !== undefined) {
                    t[u[s]] = i[u[s]]
                }
            }
            if (i.log !== undefined) {
                this.log = i.log
            }
            if (!this.log) {
                this.log = function() {}
            }
            for (o in this.plugins) {
                if (this.plugins.hasOwnProperty(o)) {
                    if (i[o] && i[o].hasOwnProperty("enabled") && i[o].enabled === false) {
                        t.disabled_plugins[o] = 1;
                        continue
                    }
                    if (t.disabled_plugins[o]) {
                        delete t.disabled_plugins[o]
                    }
                    if (typeof this.plugins[o].init === "function") {
                        this.plugins[o].init(i)
                    }
                }
            }
            if (t.handlers_attached) {
                return this
            }
            if (!t.onloadfired && (i.autorun === undefined || i.autorun !== false)) {
                if (r.readyState && r.readyState === "complete") {
                    this.setImmediate(BOOMR.page_ready, null, null, BOOMR)
                } else {
                    if (e.onpagehide || e.onpagehide === null) {
                        n.utils.addListener(e, "pageshow", BOOMR.page_ready)
                    } else {
                        n.utils.addListener(e, "load", BOOMR.page_ready)
                    }
                }
            }
            n.utils.addListener(e, "DOMContentLoaded", function() {
                t.fireEvent("dom_loaded")
            });
            (function() {
                var i, s, o;
                i = function() {
                    t.fireEvent("visibility_changed")
                };
                if (r.webkitVisibilityState) {
                    n.utils.addListener(r, "webkitvisibilitychange", i)
                } else if (r.msVisibilityState) {
                    n.utils.addListener(r, "msvisibilitychange", i)
                } else if (r.visibilityState) {
                    n.utils.addListener(r, "visibilitychange", i)
                }
                n.utils.addListener(r, "mouseup", t.onclick_handler);
                s = r.getElementsByTagName("form");
                for (o = 0; o < s.length; o++) {
                    n.utils.addListener(s[o], "submit", t.onsubmit_handler)
                }
                if (!e.onpagehide && e.onpagehide !== null) {
                    n.utils.addListener(e, "unload", function() {
                        BOOMR.window = e = null
                    })
                }
            })();
            t.handlers_attached = true;
            return this
        },
        page_ready: function(n) {
            if (!n) {
                n = e.event
            }
            if (!n) {
                n = {
                    name: "load"
                }
            }
            if (t.onloadfired) {
                return this
            }
            t.fireEvent("page_ready", n);
            t.onloadfired = true;
            return this
        },
        setImmediate: function(t, n, r, i) {
            var s = function() {
                t.call(i || null, n, r || {});
                s = null
            };
            if (e.setImmediate) {
                e.setImmediate(s)
            } else if (e.msSetImmediate) {
                e.msSetImmediate(s)
            } else if (e.webkitSetImmediate) {
                e.webkitSetImmediate(s)
            } else if (e.mozSetImmediate) {
                e.mozSetImmediate(s)
            } else {
                setTimeout(s, 10)
            }
        },
        subscribe: function(r, i, s, o) {
            var u, a, f, l;
            if (!t.events.hasOwnProperty(r)) {
                return this
            }
            f = t.events[r];
            for (u = 0; u < f.length; u++) {
                a = f[u];
                if (a[0] === i && a[1] === s && a[2] === o) {
                    return this
                }
            }
            f.push([i, s || {}, o || null]);
            if (r === "page_ready" && t.onloadfired) {
                this.setImmediate(i, null, s, o)
            }
            if (r === "page_unload") {
                l = function(t) {
                    if (i) {
                        i.call(o, t || e.event, s)
                    }
                };
                if (e.onpagehide || e.onpagehide === null) {
                    n.utils.addListener(e, "pagehide", l)
                } else {
                    n.utils.addListener(e, "unload", l)
                }
                n.utils.addListener(e, "beforeunload", l)
            }
            return this
        },
        addVar: function(e, n) {
            if (typeof e === "string") {
                t.vars[e] = n
            } else if (typeof e === "object") {
                var r = e,
                    i;
                for (i in r) {
                    if (r.hasOwnProperty(i)) {
                        t.vars[i] = r[i]
                    }
                }
            }
            return this
        },
        removeVar: function(e) {
            var n, r;
            if (!arguments.length) {
                return this
            }
            if (arguments.length === 1 && Object.prototype.toString.apply(e) === "[object Array]") {
                r = e
            } else {
                r = arguments
            }
            for (n = 0; n < r.length; n++) {
                if (t.vars.hasOwnProperty(r[n])) {
                    delete t.vars[r[n]]
                }
            }
            return this
        },
        requestStart: function(e) {
            var t = (new Date).getTime();
            BOOMR.plugins.RT.startTimer("xhr_" + e, t);
            return {
                loaded: function() {
                    BOOMR.responseEnd(e, t)
                }
            }
        },
        responseEnd: function(e, n) {
            BOOMR.plugins.RT.startTimer("xhr_" + e, n);
            t.fireEvent("xhr_load", {
                name: "xhr_" + e
            })
        },
        sendBeacon: function() {
            var n, i, s, o = 0;
            BOOMR.debug("Checking if we can send beacon");
            for (n in this.plugins) {
                if (this.plugins.hasOwnProperty(n)) {
                    if (t.disabled_plugins[n]) {
                        continue
                    }
                    if (!this.plugins[n].is_complete()) {
                        BOOMR.debug("Plugin " + n + " is not complete, deferring beacon send");
                        return this
                    }
                }
            }
            t.vars.v = BOOMR.version;
            t.vars.u = BOOMR.utils.cleanupURL(r.URL.replace(/#.*/, ""));
            if (e !== window) {
                t.vars["if"] = ""
            }
            t.fireEvent("before_beacon", t.vars);
            if (!t.beacon_url) {
                return this
            }
            i = [];
            for (n in t.vars) {
                if (t.vars.hasOwnProperty(n)) {
                    o++;
                    i.push(encodeURIComponent(n) + "=" + (t.vars[n] === undefined || t.vars[n] === null ? "" : encodeURIComponent(t.vars[n])))
                }
            }
            i = t.beacon_url + (t.beacon_url.indexOf("?") > -1 ? "&" : "?") + i.join("&");
            BOOMR.debug("Sending url: " + i.replace(/&/g, "\n	"));
            if (o) {
                s = new Image;
                s.src = i
            }
            return this
        }
    };
    delete BOOMR_start;
    if (typeof BOOMR_lstart === "number") {
        n.t_lstart = BOOMR_lstart;
        delete BOOMR_lstart
    } else if (typeof BOOMR.window.BOOMR_lstart === "number") {
        n.t_lstart = BOOMR.window.BOOMR_lstart
    }(function() {
        var t;
        if (e.YAHOO && e.YAHOO.widget && e.YAHOO.widget.Logger) {
            n.log = e.YAHOO.log
        } else if (e.Y && e.Y.log) {
            n.log = e.Y.log
        } else if (typeof console === "object" && console.log !== undefined) {
            n.log = function(e, t, n) {
                console.log(n + ": [" + t + "] " + e)
            }
        }
        t = function(e) {
            return function(t, n) {
//                this.log(t, e, "boomerang" + (n ? "." + n : ""));
                return this
            }
        };
        n.debug = t("debug");
        n.info = t("info");
        n.warn = t("warn");
        n.error = t("error")
    })();
    (function() {
        var e;
        for (e in n) {
            if (n.hasOwnProperty(e)) {
                BOOMR[e] = n[e]
            }
        }
    })();
    BOOMR.plugins = BOOMR.plugins || {}
})(window);
(function(e) {
    if (BOOMR_in_iframe()) return;
    var t = e.document,
        n;
    BOOMR = BOOMR || {};
    BOOMR.plugins = BOOMR.plugins || {};
    n = {
        initialized: false,
        complete: false,
        timers: {},
        cookie: "RT",
        cookie_exp: 600,
        strict_referrer: true,
        navigationType: 0,
        navigationStart: undefined,
        responseStart: undefined,
        t_start: undefined,
        t_fb_approx: undefined,
        r: undefined,
        r2: undefined,
        updateCookie: function(e, n) {
            var r, i, s, o;
            if (!this.cookie) {
                return this
            }
            if (typeof e === "object" && n === undefined) {
                n = e;
                e = undefined
            }
            s = BOOMR.utils.getSubCookies(BOOMR.utils.getCookie(this.cookie)) || {};
            if (typeof n === "object") {
                for (o in n) {
                    if (n.hasOwnProperty(o)) {
                        if (n[o] === undefined) {
                            if (s.hasOwnProperty(o)) {
                                delete s[o]
                            }
                        } else {
                            if (o === "nu" || o === "r") {
                                n[o] = BOOMR.utils.hashQueryString(n[o], true)
                            }
                            s[o] = n[o]
                        }
                    }
                }
            }
            s.r = BOOMR.utils.hashQueryString(t.URL, true);
            i = (new Date).getTime();
            if (e) {
                s[e] = i
            }
            BOOMR.debug("Setting cookie (timer=" + e + ")\n" + BOOMR.utils.objectToString(s), "rt");
            if (!BOOMR.utils.setCookie(this.cookie, s, this.cookie_exp)) {
                BOOMR.error("cannot set start cookie", "rt");
                return this
            }
            r = (new Date).getTime();
            if (r - i > 50) {
                BOOMR.utils.removeCookie(this.cookie);
                BOOMR.error("took more than 50ms to set cookie... aborting: " + i + " -> " + r, "rt")
            }
            return this
        },
        initFromCookie: function() {
            var e, n;
            n = BOOMR.utils.getSubCookies(BOOMR.utils.getCookie(this.cookie));
            if (!n) {
                return
            }
            n.s = Math.max(+n.ul || 0, +n.cl || 0);
            BOOMR.debug("Read from cookie " + BOOMR.utils.objectToString(n), "rt");
            if (n.s && (n.r || n.nu)) {
                this.r = n.r;
                e = BOOMR.utils.hashQueryString(t.URL, true);
                BOOMR.debug(this.r + " =?= " + this.r2, "rt");
                BOOMR.debug(n.s + " <? " + (+n.cl + 15), "rt");
                BOOMR.debug(n.nu + " =?= " + e, "rt");
                if (!this.strict_referrer || n.nu && n.nu === e && n.s < +n.cl + 15 || n.s === +n.ul && this.r === this.r2) {
                    this.t_start = n.s;
                    if (+n.hd > n.s) {
                        this.t_fb_approx = parseInt(n.hd, 10)
                    }
                } else {
                    this.t_start = this.t_fb_approx = undefined
                }
            }
            this.updateCookie({
                s: undefined,
                r: undefined,
                nu: undefined,
                ul: undefined,
                cl: undefined,
                hd: undefined
            })
        },
        getBoomerangTimings: function() {
            var e, t, n, r;
            if (BOOMR.t_start) {
                BOOMR.plugins.RT.startTimer("boomerang", BOOMR.t_start);
                BOOMR.plugins.RT.endTimer("boomerang", BOOMR.t_end);
                BOOMR.plugins.RT.endTimer("boomr_fb", BOOMR.t_start)
            }
            if (window.performance && window.performance.getEntriesByName) {
                n = {
                    "rt.bmr.": BOOMR.url
                };
                for (r in n) {
                    if (n.hasOwnProperty(r) && n[r]) {
                        e = window.performance.getEntriesByName(n[r]);
                        if (!e || e.length === 0) {
                            continue
                        }
                        e = e[0];
                        for (t in e) {
                            if (e.hasOwnProperty(t) && t.match(/(Start|End)$/) && e[t] > 0) {
                                BOOMR.addVar(r + t.replace(/^(...).*(St|En).*$/, "$1$2"), e[t])
                            }
                        }
                    }
                }
            }
        },
        checkPreRender: function() {
            if (!(t.webkitVisibilityState && t.webkitVisibilityState === "prerender") && !(t.msVisibilityState && t.msVisibilityState === 3)) {
                return false
            }
            BOOMR.plugins.RT.startTimer("t_load", this.navigationStart);
            BOOMR.plugins.RT.endTimer("t_load");
            BOOMR.plugins.RT.startTimer("t_prerender", this.navigationStart);
            BOOMR.plugins.RT.startTimer("t_postrender");
            BOOMR.subscribe("visibility_changed", BOOMR.plugins.RT.done, null, BOOMR.plugins.RT);
            return true
        },
        initNavTiming: function() {
            var t, n, r;
            if (this.navigationStart) {
                return
            }
            n = e.performance || e.msPerformance || e.webkitPerformance || e.mozPerformance;
            if (n && n.navigation) {
                this.navigationType = n.navigation.type
            }
            if (n && n.timing) {
                t = n.timing
            } else if (e.chrome && e.chrome.csi && e.chrome.csi().startE) {
                t = {
                    navigationStart: e.chrome.csi().startE
                };
                r = "csi"
            } else if (e.gtbExternal && e.gtbExternal.startE()) {
                t = {
                    navigationStart: e.gtbExternal.startE()
                };
                r = "gtb"
            }
            if (t) {
                BOOMR.addVar("rt.start", r || "navigation");
                this.navigationStart = t.navigationStart || t.fetchStart || undefined;
                this.responseStart = t.responseStart || undefined;
                if (navigator.userAgent.match(/Firefox\/[78]\./)) {
                    this.navigationStart = t.unloadEventStart || t.fetchStart || undefined
                }
            } else {
                BOOMR.warn("This browser doesn't support the WebTiming API", "rt")
            }
            return
        },
        page_unload: function(e) {
            BOOMR.debug("Unload called with " + BOOMR.utils.objectToString(e), "rt");
            this.updateCookie(e.type === "beforeunload" ? "ul" : "hd")
        },
        _iterable_click: function(e, t, n, r) {
            if (!n) {
                return
            }
            BOOMR.debug(e + " called with " + n.nodeName, "rt");
            while (n && n.nodeName.toUpperCase() !== t) {
                n = n.parentNode
            }
            if (n && n.nodeName.toUpperCase() === t) {
                BOOMR.debug("passing through", "rt");
                this.updateCookie("cl", {
                    nu: r(n)
                })
            }
        },
        onclick: function(e) {
            n._iterable_click("Click", "A", e, function(e) {
                return e.href
            })
        },
        onsubmit: function(e) {
            n._iterable_click("Submit", "FORM", e, function(e) {
                var n = e.action || t.URL;
                return n.match(/\?/) ? n : n + "?"
            })
        },
        domloaded: function() {
            BOOMR.plugins.RT.endTimer("t_domloaded")
        }
    };
    BOOMR.plugins.RT = {
        init: function(r) {
            BOOMR.debug("init RT", "rt");
            if (e !== BOOMR.window) {
                e = BOOMR.window;
                t = e.document
            }
            BOOMR.utils.pluginConfig(n, r, "RT", ["cookie", "cookie_exp", "strict_referrer"]);
            n.initFromCookie();
            n.updateCookie(null, false);
            if (n.initialized) {
                return this
            }
            n.complete = false;
            n.timers = {};
            BOOMR.subscribe("page_ready", this.done, null, this);
            BOOMR.subscribe("dom_loaded", n.domloaded, null, n);
            BOOMR.subscribe("page_unload", n.page_unload, null, n);
            BOOMR.subscribe("click", n.onclick, null, n);
            BOOMR.subscribe("form_submit", n.onsubmit, null, n);
            if (BOOMR.t_start) {
                this.startTimer("boomerang", BOOMR.t_start);
                this.endTimer("boomerang", BOOMR.t_end);
                this.endTimer("boomr_fb", BOOMR.t_start)
            }
            n.r = n.r2 = BOOMR.utils.hashQueryString(t.referrer, true);
            n.initialized = true;
            return this
        },
        startTimer: function(e, t) {
            if (e) {
                if (e === "t_page") {
                    this.endTimer("t_resp", t)
                }
                n.timers[e] = {
                    start: typeof t === "number" ? t : (new Date).getTime()
                };
                n.complete = false
            }
            return this
        },
        endTimer: function(e, t) {
            if (e) {
                n.timers[e] = n.timers[e] || {};
                if (n.timers[e].end === undefined) {
                    n.timers[e].end = typeof t === "number" ? t : (new Date).getTime()
                }
            }
            return this
        },
        setTimer: function(e, t) {
            if (e) {
                n.timers[e] = {
                    delta: t
                }
            }
            return this
        },
        done: function() {
            BOOMR.debug("Called done", "rt");
            var e, t = (new Date).getTime(),
                r = {
                    t_done: 1,
                    t_resp: 1,
                    t_page: 1
                },
                i = 0,
                s, o, u = [];
            n.complete = false;
            n.initFromCookie();
            n.initNavTiming();
            if (n.checkPreRender()) {
                return this
            }
            if (n.responseStart) {
                this.endTimer("t_resp", n.responseStart);
                if (n.timers.t_load) {
                    this.setTimer("t_page", n.timers.t_load.end - n.responseStart)
                } else {
                    this.setTimer("t_page", t - n.responseStart)
                }
            } else if (n.timers.hasOwnProperty("t_page")) {
                this.endTimer("t_page")
            } else if (n.t_fb_approx) {
                this.endTimer("t_resp", n.t_fb_approx);
                this.setTimer("t_page", t - n.t_fb_approx)
            }
            if (n.timers.hasOwnProperty("t_postrender")) {
                this.endTimer("t_postrender");
                this.endTimer("t_prerender")
            }
            if (n.navigationStart) {
                e = n.navigationStart
            } else if (n.t_start && n.navigationType !== 2) {
                e = n.t_start;
                BOOMR.addVar("rt.start", "cookie")
            } else {
                BOOMR.addVar("rt.start", "none");
                e = undefined
            }
            BOOMR.debug("Got start time: " + e);
            this.endTimer("t_done", t);
            BOOMR.removeVar("t_done", "t_page", "t_resp", "r", "r2", "rt.tstart", "rt.bstart", "rt.end", "t_postrender", "t_prerender", "t_load");
            BOOMR.addVar("rt.tstart", e);
            BOOMR.addVar("rt.bstart", BOOMR.t_start);
            BOOMR.addVar("rt.end", n.timers.t_done.end);
            for (s in n.timers) {
                if (n.timers.hasOwnProperty(s)) {
                    o = n.timers[s];
                    if (typeof o.delta !== "number") {
                        if (typeof o.start !== "number") {
                            o.start = e
                        }
                        o.delta = o.end - o.start
                    }
                    if (isNaN(o.delta)) {
                        continue
                    }
                    if (r.hasOwnProperty(s)) {
                        BOOMR.addVar(s, o.delta)
                    } else {
                        u.push(s + "|" + o.delta)
                    }
                    i++
                }
            }
            if (i) {
                BOOMR.addVar("r", BOOMR.utils.cleanupURL(n.r));
                if (n.r2 !== n.r) {
                    BOOMR.addVar("r2", BOOMR.utils.cleanupURL(n.r2))
                }
                if (u.length) {
                    BOOMR.addVar("t_other", u.join(","))
                }
            }
            n.timers = {};
            n.complete = true;
            BOOMR.sendBeacon();
            return this
        },
        is_complete: function() {
            return n.complete
        }
    }
})(window);
(function(e) {
    if (BOOMR_in_iframe()) return;
    BOOMR = BOOMR || {};
    BOOMR.plugins = BOOMR.plugins || {};
    BOOMR.addVar("nt", "0");
    var t = {
        complete: false,
        done: function() {
            var e = BOOMR.window,
                t, n, r, i;
            t = e.performance || e.msPerformance || e.webkitPerformance || e.mozPerformance;
            if (t && t.timing && t.navigation) {
                BOOMR.info("This user agent supports NavigationTiming.", "nt");
                n = t.navigation;
                r = t.timing;
                BOOMR.removeVar("nt");
                BOOMR.addVar("nt", "1");
                i = {
                    nt_red_cnt: n.redirectCount,
                    nt_nav_type: n.type,
                    nt_nav_st: r.navigationStart,
                    nt_red_st: r.redirectStart,
                    nt_red_end: r.redirectEnd,
                    nt_fet_st: r.fetchStart,
                    nt_dns_st: r.domainLookupStart,
                    nt_dns_end: r.domainLookupEnd,
                    nt_con_st: r.connectStart,
                    nt_con_end: r.connectEnd,
                    nt_req_st: r.requestStart,
                    nt_res_st: r.responseStart,
                    nt_res_end: r.responseEnd,
                    nt_domloading: r.domLoading,
                    nt_domint: r.domInteractive,
                    nt_domcontloaded_st: r.domContentLoadedEventStart,
                    nt_domcontloaded_end: r.domContentLoadedEventEnd,
                    nt_domcomp: r.domComplete,
                    nt_load_st: r.loadEventStart,
                    nt_load_end: r.loadEventEnd,
                    nt_unload_st: r.unloadEventStart,
                    nt_unload_end: r.unloadEventEnd
                };
                if (r.secureConnectionStart) {
                    i.nt_ssl_st = r.secureConnectionStart
                }
                if (r.msFirstPaint) {
                    i.nt_first_paint = r.msFirstPaint
                }
                BOOMR.addVar(i)
            }
            if (e.chrome && e.chrome.loadTimes) {
                r = e.chrome.loadTimes();
                if (r) {
                    i = {
                        nt_spdy: r.wasFetchedViaSpdy ? 1 : 0,
                        nt_first_paint: r.firstPaintTime
                    };
                    BOOMR.addVar(i)
                }
            }
            this.complete = true;
            BOOMR.sendBeacon()
        }
    };
    BOOMR.plugins.NavigationTiming = {
        init: function() {
            BOOMR.subscribe("page_ready", t.done, null, t);
            return this
        },
        is_complete: function() {
            return t.complete
        }
    }
})(window);
(function() {
    if (BOOMR_in_iframe()) return;
    var e;
    if (typeof navigator === "object") {
        e = navigator.connection || navigator.mozConnection || navigator.webkitConnection || navigator.msConnection
    }
    if (!e) {
        return
    }
    BOOMR.addVar("mob.ct", e.type);
    BOOMR.addVar("mob.bw", e.bandwidth);
    BOOMR.addVar("mob.mt", e.metered)
})();
if (BOOMR_in_iframe()) {
    BOOMR = {};
    BOOMR.init = function() {}
} else {
    BOOMR.t_end = (new Date).getTime();
    BOOMR.addVar("request", "nw_info")
}

