# Block 1: Define upstream server's host and port.

# Location of BP.
backend behttp {
  .host = "127.0.0.1";
  .port = "9080";
}
backend behttps {
  .host = "127.0.0.1";
  .port = "9443";
}
backend bepstatic01_mgo_images_com {
  .host = "pstatic01.mgo-images.com";
  .port = "http";
}
backend bepstatic09_mgo_images_com {
  .host = "pstatic09.mgo-images.com";
  .port = "http";
}
backend bepstatic03_mgo_images_com {
  .host = "pstatic03.mgo-images.com";
  .port = "http";
}
backend bepstatic02_mgo_images_com {
  .host = "pstatic02.mgo-images.com";
  .port = "http";
}
backend bepstatic04_mgo_images_com {
  .host = "pstatic04.mgo-images.com";
  .port = "http";
}

# Block 2: Define a key based on the User-Agent which can be used for hashing.
# Also set the PS-CapabilityList header for PageSpeed server to respect.
sub generate_user_agent_based_key {
    # Define placeholder PS-CapabilityList header values for large and small
    # screens with no UA dependent optimizations. Note that these placeholder
    # values should not contain any of ll, ii, dj, jw or ws, since these
    # codes will end up representing optimizations to be supported for the
    # request.
    set req.http.default_ps_capability_list_for_large_screens = "LargeScreen.SkipUADependentOptimizations:";
    set req.http.default_ps_capability_list_for_small_screens = "TinyScreen.SkipUADependentOptimizations:";

    # As a fallback, the PS-CapabilityList header that is sent to the upstream
    # PageSpeed server should be for a large screen device with no browser
    # specific optimizations.
    set req.http.PS-CapabilityList = req.http.default_ps_capability_list_for_large_screens;

    # Cache-fragment 1: Desktop User-Agents that support lazyload_images (ll),
    # inline_images (ii) and defer_javascript (dj).
    # Note: Wget is added for testing purposes only.
    if (req.http.User-Agent ~ "(?i)Chrome/|Firefox/|MSIE |Safari|Wget") {
      set req.http.PS-CapabilityList = "ll,ii,dj:";
    }
    # Cache-fragment 2: Desktop User-Agents that support lazyload_images (ll),
    # inline_images (ii), defer_javascript (dj), webp (jw) and lossless_webp
    # (ws).
    if (req.http.User-Agent ~
        "(?i)Chrome/[2][3-9]+\.|Chrome/[[3-9][0-9]+\.|Chrome/[0-9]{3,}\.") {
      set req.http.PS-CapabilityList = "ll,ii,dj,jw,ws:";
    }
    # Cache-fragment 3: This fragment contains (a) Desktop User-Agents that
    # match fragments 1 or 2 but should not because they represent older
    # versions of certain browsers or bots and (b) Tablet User-Agents that
    # on all browsers and use image compression qualities applicable to large
    # screens. Note that even Tablets that are capable of supporting inline or
    # webp images, e.g. Android 4.1.2, will not get these advanced
    # optimizations.
    if (req.http.User-Agent ~ "(?i)Firefox/[1-2]\.|MSIE [5-8]\.|bot|Yahoo!|Ruby|RPT-HTTPClient|(Google \(\+https\:\/\/developers\.google\.com\/\+\/web\/snippet\/\))|Android|iPad|TouchPad|Silk-Accelerated|Kindle Fire") {
      set req.http.PS-CapabilityList = req.http.default_ps_capability_list_for_large_screens;
    }
    # Cache-fragment 4: Mobiles and small screen Tablets will use image compression
    # qualities applicable to small screens, but all other optimizations will be
    # those that work on all browsers.
    if (req.http.User-Agent ~ "(?i)Mozilla.*Android.*Mobile*|iPhone|BlackBerry|Opera Mobi|Opera Mini|SymbianOS|UP.Browser|J-PHONE|Profile/MIDP|portalmmm|DoCoMo|Obigo|Galaxy Nexus|GT-I9300|GT-N7100|HTC One|Nexus [4|7|S]|Xoom|XT907") {
      set req.http.PS-CapabilityList = req.http.default_ps_capability_list_for_small_screens;
    }
    # Remove placeholder header values.
    remove req.http.default_ps_capability_list_for_large_screens;
    remove req.http.default_ps_capability_list_for_large_screens;
}

sub vcl_hash {
  # SORIN: restore original X-Forwarded-For
  set req.http.X-Forwarded-For = req.http.X-Forwarded-For-orig;
  unset req.http.X-Forwarded-For-orig;

  # Block 3: Use the PS-CapabilityList value for computing the hash.
  hash_data(req.http.PS-CapabilityList);
}

# Block 3a: Define ACL for purge requests
acl purgehttp_451research_revsw_net {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "dfw02-co01.revsw.net";
}
acl purgehttps_451research_revsw_net {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "dfw02-co01.revsw.net";
}
acl purgehttp_gogobot_revsw_net {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "SJC02-CO01";
}
acl purgehttps_gogobot_revsw_net {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "SJC02-CO01";
}
acl purgehttp_m_mgo_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "lax02-co01.revsw.net";
}
acl purgehttps_m_mgo_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "lax02-co01.revsw.net";
}
acl purgehttp_monitor_revsw_net {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "IAD02-CO01";
}
acl purgehttps_monitor_revsw_net {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "IAD02-CO01";
}
acl purgehttp_naw3_central_arubanetworks_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "sjc02-co01.revsw.net";
}
acl purgehttps_naw3_central_arubanetworks_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "sjc02-co01.revsw.net";
}
acl purgehttp_openbook_rev_etoro_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "LON02-CO01";
}
acl purgehttps_openbook_rev_etoro_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "LON02-CO01";
}
acl purgehttp_rev_treato_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "192.73.248.210";
}
acl purgehttps_rev_treato_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "192.73.248.210";
}
acl purgehttp_revtest_451research_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "dfw02-co01.revsw.net";
}
acl purgehttps_revtest_451research_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "dfw02-co01.revsw.net";
}
acl purgehttp_revtest_central_arubanetworks_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "SJC02-CO01";
}
acl purgehttps_revtest_central_arubanetworks_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "SJC02-CO01";
}
acl purgehttp_revtest_central_arunetworks_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "dfw02-co01.revsw.net";
}
acl purgehttps_revtest_central_arunetworks_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "dfw02-co01.revsw.net";
}
acl purgehttp_revtest_cloud_arubanetworks_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "sjc02-co01.revsw.net";
}
acl purgehttps_revtest_cloud_arubanetworks_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "sjc02-co01.revsw.net";
}
acl purgehttp_revtest_dyn_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "PHX02-CO01";
}
acl purgehttps_revtest_dyn_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "PHX02-CO01";
}
acl purgehttp_revtest_handyspaces_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "sjc02-co01.revsw.net";
}
acl purgehttps_revtest_handyspaces_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "sjc02-co01.revsw.net";
}
acl purgehttp_revtest_landoceanrestaurants_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "phx02-co01.revsw.net";
}
acl purgehttps_revtest_landoceanrestaurants_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "phx02-co01.revsw.net";
}
acl purgehttp_revtest_mgo_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "lax02-co01.revsw.net";
}
acl purgehttps_revtest_mgo_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "lax02-co01.revsw.net";
}
acl purgehttp_revtest_mygraphs_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "IAD02-CO01";
}
acl purgehttps_revtest_mygraphs_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "IAD02-CO01";
}
acl purgehttp_revtest_nextstepgrowth_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "IAD02-CO01.REVSW.NET";
}
acl purgehttps_revtest_nextstepgrowth_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "IAD02-CO01.REVSW.NET";
}
acl purgehttp_revtest_nsone_net {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "IAD02-CO01";
}
acl purgehttps_revtest_nsone_net {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "IAD02-CO01";
}
acl purgehttp_revtest_rightwave_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "sjc02-co01.revsw.net";
}
acl purgehttps_revtest_rightwave_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "sjc02-co01.revsw.net";
}
acl purgehttp_revtest_siennarestaurants_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "lax20-co01.revsw.net";
}
acl purgehttps_revtest_siennarestaurants_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "lax20-co01.revsw.net";
}
acl purgehttp_revtest_webgistix_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "dfw02-co01.revsw.net";
}
acl purgehttps_revtest_webgistix_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "dfw02-co01.revsw.net";
}
acl purgehttp_www_universini_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "SJC02-CO01";
}
acl purgehttps_www_universini_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "SJC02-CO01";
}
acl purgehttp_www_victor_gartvich_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "SJC02-CO01";
}
acl purgehttps_www_victor_gartvich_com {
  # Purge requests are only allowed from localhost.
  "localhost";
  "127.0.0.1";
  "SJC02-CO01";
}

# Block 3b: Issue purge when there is a cache hit for the purge request.
sub vcl_hit {
  if (req.request == "PURGE") {
    purge;
    error 200 "Purged.";
  }
  set req.http.X-Rev-obj-ttl = obj.ttl;
  set req.http.X-Rev-obj-grace = obj.grace;
  set req.http.X-Rev-fetch-start = now;
}

# Block 3c: Issue a no-op purge when there is a cache miss for the purge
# request.
sub vcl_miss {
  if (req.request == "PURGE") {
     purge;
     error 200 "Purged.";
  }
  set req.http.X-Rev-fetch-start = now;
}

# Block 4: In vcl_recv, on receiving a request, call the method responsible for
# generating the User-Agent based key for hashing into the cache.
sub vcl_recv {
  # SORIN: save original X-Forwarded-For, we don't want to let Varnish modify it.
  # We'll restore it in vcl_hash.
  set req.http.X-Forwarded-For-orig = req.http.X-Forwarded-For;
  unset req.http.X-Forwarded-For;

  # Remove shards from hostname
  set req.http.Host = regsub(req.http.Host, "^s\d+\.", "");

  if (server.port == 8080) {
    set req.backend = behttp;
  }
  else {
    set req.backend = behttps;
  }

  call generate_user_agent_based_key;
  # Block 3d: Verify the ACL for an incoming purge request and handle it.
  if (req.request == "PURGE") {
    if (req.http.host == "451research.revsw.net") {
      if ((server.port == 8080 && client.ip !~ purgehttp_451research_revsw_net) ||
          (server.port == 8443 && client.ip !~ purgehttps_451research_revsw_net)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "gogobot.revsw.net") {
      if ((server.port == 8080 && client.ip !~ purgehttp_gogobot_revsw_net) ||
          (server.port == 8443 && client.ip !~ purgehttps_gogobot_revsw_net)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "m.mgo.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_m_mgo_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_m_mgo_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "monitor.revsw.net") {
      if ((server.port == 8080 && client.ip !~ purgehttp_monitor_revsw_net) ||
          (server.port == 8443 && client.ip !~ purgehttps_monitor_revsw_net)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "naw3.central.arubanetworks.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_naw3_central_arubanetworks_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_naw3_central_arubanetworks_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "openbook-rev.etoro.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_openbook_rev_etoro_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_openbook_rev_etoro_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "rev.treato.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_rev_treato_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_rev_treato_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "revtest.451research.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_revtest_451research_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_revtest_451research_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "revtest.central.arubanetworks.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_revtest_central_arubanetworks_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_revtest_central_arubanetworks_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "revtest.central.arunetworks.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_revtest_central_arunetworks_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_revtest_central_arunetworks_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "revtest.cloud.arubanetworks.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_revtest_cloud_arubanetworks_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_revtest_cloud_arubanetworks_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "revtest.dyn.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_revtest_dyn_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_revtest_dyn_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "revtest.handyspaces.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_revtest_handyspaces_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_revtest_handyspaces_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "revtest.landoceanrestaurants.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_revtest_landoceanrestaurants_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_revtest_landoceanrestaurants_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "revtest.mgo.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_revtest_mgo_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_revtest_mgo_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "revtest.mygraphs.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_revtest_mygraphs_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_revtest_mygraphs_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "revtest.nextstepgrowth.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_revtest_nextstepgrowth_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_revtest_nextstepgrowth_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "revtest.nsone.net") {
      if ((server.port == 8080 && client.ip !~ purgehttp_revtest_nsone_net) ||
          (server.port == 8443 && client.ip !~ purgehttps_revtest_nsone_net)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "revtest.rightwave.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_revtest_rightwave_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_revtest_rightwave_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "revtest.siennarestaurants.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_revtest_siennarestaurants_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_revtest_siennarestaurants_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "revtest.webgistix.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_revtest_webgistix_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_revtest_webgistix_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "www.universini.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_www_universini_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_www_universini_com)) {
        error 405 "Not allowed.";
      }
    }
    elsif (req.http.host == "www.victor-gartvich.com") {
      if ((server.port == 8080 && client.ip !~ purgehttp_www_victor_gartvich_com) ||
          (server.port == 8443 && client.ip !~ purgehttps_www_victor_gartvich_com)) {
        error 405 "Not allowed.";
      }
    }
    return (lookup);
  }

  # Blocks which decide whether cache should be bypassed or not go here.

  # Block 5a: Bypass the cache for .pagespeed. resource. PageSpeed has its own
  # cache for these, and these could bloat up the caching layer.
  #if (req.url ~ "\.pagespeed\.([a-z]\.)?[a-z]{2}\.[^.]{10}\.[^.]+") {
  #  # Skip the cache for .pagespeed. resource.  PageSpeed has its own
  #  # cache for these, and these could bloat up the caching layer.
  #  return (pass);
  #}

  # Block 5b: Only cache responses to clients that support gzip.  Most clients
  # do, and the cache holds much more if it stores gzipped responses.
  if (req.http.Accept-Encoding !~ "gzip") {
    return (pass);
  }

  # Sorin: If the URL refers to a static resource (image, script, stylesheet) then
  # remove Cookie to simplify caching.
  if (req.http.Cookie) {
    if (req.http.host == "451research.revsw.net") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "gogobot.revsw.net") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "m.mgo.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
          || req.url ~ "image/thumbnail"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "monitor.revsw.net") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "naw3.central.arubanetworks.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "openbook-rev.etoro.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "rev.treato.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "revtest.451research.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "revtest.central.arubanetworks.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "revtest.central.arunetworks.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "revtest.cloud.arubanetworks.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "revtest.dyn.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "revtest.handyspaces.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "revtest.landoceanrestaurants.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "revtest.mgo.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
          || req.url ~ "image/thumbnail"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "revtest.mygraphs.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "revtest.nextstepgrowth.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "revtest.nsone.net") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "revtest.rightwave.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "revtest.siennarestaurants.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "revtest.webgistix.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "www.universini.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
    elsif (req.http.host == "www.victor-gartvich.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove req.http.Cookie;
      }
    }
  }

  if (req.url ~ "^/pstatic01\.mgo-images\.com/") {
    set req.backend = bepstatic01_mgo_images_com;
    set req.http.host = "pstatic01.mgo-images.com";
    set req.url = regsub(req.url, "pstatic01\.mgo-images\.com/", "/");
    set req.http.X-PStatic = "YES";
  }
  elsif (req.url ~ "^/pstatic09\.mgo-images\.com/") {
    set req.backend = bepstatic09_mgo_images_com;
    set req.http.host = "pstatic09.mgo-images.com";
    set req.url = regsub(req.url, "pstatic09\.mgo-images\.com/", "/");
    set req.http.X-PStatic = "YES";
  }
  elsif (req.url ~ "^/pstatic03\.mgo-images\.com/") {
    set req.backend = bepstatic03_mgo_images_com;
    set req.http.host = "pstatic03.mgo-images.com";
    set req.url = regsub(req.url, "pstatic03\.mgo-images\.com/", "/");
    set req.http.X-PStatic = "YES";
  }
  elsif (req.url ~ "^/pstatic02\.mgo-images\.com/") {
    set req.backend = bepstatic02_mgo_images_com;
    set req.http.host = "pstatic02.mgo-images.com";
    set req.url = regsub(req.url, "pstatic02\.mgo-images\.com/", "/");
    set req.http.X-PStatic = "YES";
  }
  elsif (req.url ~ "^/pstatic04\.mgo-images\.com/") {
    set req.backend = bepstatic04_mgo_images_com;
    set req.http.host = "pstatic04.mgo-images.com";
    set req.url = regsub(req.url, "pstatic04\.mgo-images\.com/", "/");
    set req.http.X-PStatic = "YES";
  }
  else {
    set req.http.X-PStatic = "NO";
  }
}

# Block 6: Mark HTML uncacheable by caches beyond our control.
sub vcl_fetch {
  # Don't cache error pages.
  if (beresp.status > 400) {
    set beresp.ttl = 0s;
  }

  # Sorin: If the URL refers to a static resource (see above) then remove
  # Set-Cookie.
  # Overiding cache control
  # if (beresp.http.Set-Cookie) {
    if (req.http.host == "451research.revsw.net") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "gogobot.revsw.net") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "m.mgo.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
          || req.url ~ "image/thumbnail"
      ) {
        remove beresp.http.Set-Cookie;
      }
      # Make sure we don't go over the Rev cache time limit
      if (beresp.ttl > 3996000s) {
        set beresp.ttl = 3996000s;
      }
    }
    elsif (req.http.host == "monitor.revsw.net") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "naw3.central.arubanetworks.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "openbook-rev.etoro.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "rev.treato.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "revtest.451research.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
      # Make sure we don't go over the Rev cache time limit
      if (beresp.ttl > 3996000s) {
        set beresp.ttl = 3996000s;
      }
    }
    elsif (req.http.host == "revtest.central.arubanetworks.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "revtest.central.arunetworks.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "revtest.cloud.arubanetworks.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "revtest.dyn.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "revtest.handyspaces.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "revtest.landoceanrestaurants.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "revtest.mgo.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
          || req.url ~ "image/thumbnail"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "revtest.mygraphs.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "revtest.nextstepgrowth.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "revtest.nsone.net") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "revtest.rightwave.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
      # Make sure we don't go over the Rev cache time limit
      if (beresp.ttl > 3996000s) {
        set beresp.ttl = 3996000s;
      }
    }
    elsif (req.http.host == "revtest.siennarestaurants.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "revtest.webgistix.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
      # Make sure we don't go over the Rev cache time limit
      if (beresp.ttl > 3996000s) {
        set beresp.ttl = 3996000s;
      }
    }
    elsif (req.http.host == "www.universini.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }
    elsif (req.http.host == "www.victor-gartvich.com") {
      if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
      ) {
        remove beresp.http.Set-Cookie;
      }
    }

    # Enable caching of objects
    if (
          req.url ~ "\.(jpg|jpeg|png|gif|webp|js|css|woff)(\?.*)?$"
          || req.url ~ "image/thumbnail"
      ) {
      /* Set the clients TTL on this object */
      set beresp.http.cache-control = "max-age=3600";

      /* Set how long Varnish will keep it */
      set beresp.ttl = 1w;

      /* marker for vcl_deliver to reset Age: */
      set beresp.http.magicmarker = "1";
    }
  #}

  if (beresp.http.Content-Type ~ "text/html") {
    # Hide the upstream cache control header.
    remove beresp.http.Cache-Control;
    # Add no-cache Cache-Control header for html.
    set beresp.http.Cache-Control = "no-cache, max-age=0";
  }

  # Remove headers set by upstream Varnish instances.
  unset beresp.http.X-Cache;
  unset beresp.http.X-Cache-Hits;

  # The Expires header is confusing and causes wrong misses.
  # Max-Age takes precedence, so eliminate the confusion.
  if (beresp.http.Cache-Control ~ "max-age") {
    unset beresp.http.Expires;
  }

  # Cache jQuery
  if (req.url ~ "jquery" && !beresp.http.Cache-Control) {
    set beresp.http.Cache-Control = "max-age=3600";
  }

  set beresp.http.X-Rev-beresp-ttl = beresp.ttl;
  set beresp.http.X-Rev-beresp-grace = beresp.grace;

  # Taken from default VCL
  if (beresp.ttl <= 0s ||
     beresp.http.Set-Cookie ||
     beresp.http.Vary == "*") {
           /*
            * Mark as "Hit-For-Pass" for the next 2 minutes
            */
           set beresp.ttl = 120 s;
           set beresp.http.X-Rev-hit-for-pass = "YES";
           return (hit_for_pass);
  }

  return (deliver);
}

# Block 7: Add a header for identifying cache hits/misses.
sub vcl_deliver {
   if (resp.http.magicmarker) {
     /* Remove the magic marker */
     unset resp.http.magicmarker;

     /* By definition we have a fresh object */
     set resp.http.age = "0";
  }
  if (obj.hits > 0) {
    set resp.http.X-Rev-Cache = "HIT";
    set resp.http.X-Rev-Cache-Hits = obj.hits;
    set resp.http.X-Rev-obj-ttl = req.http.X-Rev-obj-ttl;
    set resp.http.X-Rev-obj-grace = req.http.X-Rev-obj-grace;
  } else {
    set resp.http.X-Rev-Cache = "MISS";
  }
  set resp.http.X-Rev-fetch-start = req.http.X-Rev-fetch-start;
  set resp.http.X-Rev-fetch-end = now;
}
