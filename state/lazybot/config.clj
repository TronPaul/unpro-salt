{% set youtube_api_key = salt['pillar.get']('lazybot:youtube:api-key') %}
{% set user = salt['pillar.get']('lazybot:admin:user') %}
{% set password = salt['pillar.get']('lazybot:admin:password') %}
(let [plugins #{"http-info"
                ;; "github" how does this even work?
                ;; "rotten-tomatoes", "lastfm" needs key to verify
                ;; api broken -- "knowledge" "metacritic" (getting 403 error)
                ;;               "notifo" this service went out of business
                ;;               "shorturl" is.gd is good, bit.ly seems broken
                }]
  {:servers ["irc.gamesurge.net"]        ; A list of servers.
   :prepends #{";"}   ; The character you want for a prepend. Currently set to @
   :weather {:token ""} ; Wunderground token.
   :dictionary {:wordnik-key "99c266291da87b231f40a0c8902040da0b568588c25526cff"} ; Wordnik API key.
{% if youtube_api_key %}
   :youtube {:api-key "{{youtube_api_key}}"}
{% endif %}
   :sed {:automatic? true}
   :max-operations 3 ; The maximum number of operations that can be running at any given time.
   :pending-ops 0    ; The number of operations running right now
   :prefix-arrow "\u21D2 "
   :help {:admin-add? true  ; only admins can add help topics
          :admin-rm? true}   ; only admins can remove help topics
   :clojure {:eval-prefixes {:defaults ["->" "." "," ; prefixes in any channel
                                        #"&\|(.*?)(?=\|&|\|&|$)" ; stuff like &|this|&
                                        #"##(([^#]|#(?!#))+)\s*((##)?(?=.*##)|$)"]
                             ;; list of prefixes NOT to use in certain channels
                             "#tempchan" ["->"]   ; turn this off for testing
                             "#clojure" [","]}}    ; let clojurebot have this one
   :servers-port 8080                  ; port for plugins that require a webserver
   "irc.gamesurge.net" {:channels ["#brbuninstalling"]
                       :bot-name "TrandPaul"
                       :bot-password nil
{% if user and password %}
                       :users {"{{user}}" {:pass "{{password}}", :privs :admin}}
{% endif %}
                       :plugins plugins
                       :url-handlers #{"youtube"}
                       :http-info {:automatic? true}}})

; users is a series of username to password and privileges.
; plugins is a list of plugins to load at startup.
