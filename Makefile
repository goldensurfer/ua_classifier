PROJECT = ua_classifier

ERLC_OPTS = +debug_info +warn_export_all +warn_export_vars +warn_shadow_vars +warn_obsolete_guard

PLT_APPS = hipe sasl mnesia crypto compiler syntax_tools
DIALYZER_OPTS = -Werror_handling -Wrace_conditions -Wunmatched_returns | fgrep -v -f ./dialyzer.ignore-warning

my_all: priv/ua_classifier_drv.so all

include erlang.mk

priv/ua_classifier_drv.so:
	export ERL_PATH=`./erlang_path.escript`
	mkdir -p priv
	gcc -fPIC -shared -o priv/ua_classifier_drv.so c_src/ua_classifier_nif.c -I $(ERL_PATH)
