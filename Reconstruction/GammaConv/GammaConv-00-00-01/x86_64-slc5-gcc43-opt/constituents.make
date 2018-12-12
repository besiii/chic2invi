
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

GammaConv_tag = $(tag)

ifdef READONLY
cmt_local_tagfile = /tmp/CMT_$(GammaConv_tag).make$(cmt_lock_pid)
else
#cmt_local_tagfile = $(GammaConv_tag).make
cmt_local_tagfile = $(bin)$(GammaConv_tag).make
endif

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

ifdef READONLY
cmt_local_setup = /tmp/CMT_GammaConvsetup$(cmt_lock_pid).make
cmt_final_setup = /tmp/CMT_GammaConvsetup.make
else
#cmt_local_setup = $(bin)GammaConvsetup$(cmt_lock_pid).make
cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)GammaConvsetup.make
cmt_final_setup = $(bin)$(package)setup.make
endif

#--------------------------------------------------------

#cmt_lock_setup = /tmp/lock$(cmt_lock_pid).make
#cmt_temp_tag = /tmp/tag$(cmt_lock_pid).make

#first :: $(cmt_local_tagfile)
#	@echo $(cmt_local_tagfile) ok
ifndef QUICK
first :: $(cmt_final_setup) ;
else
first :: ;
endif

##	@bin=`$(cmtexe) show macro_value bin`

#$(cmt_local_tagfile) : $(cmt_lock_setup)
#	@echo "#CMT> Error: $@: No such file" >&2; exit 1
$(cmt_local_tagfile) :
	@echo "#CMT> Warning: $@: No such file" >&2; exit
#	@echo "#CMT> Info: $@: No need to rebuild file" >&2; exit

$(cmt_final_setup) : $(cmt_local_tagfile) 
	$(echo) "(constituents.make) Rebuilding $@"
	@if test ! -d $(@D); then $(mkdir) -p $(@D); fi; \
	  if test -f $(cmt_local_setup); then /bin/rm -f $(cmt_local_setup); fi; \
	  trap '/bin/rm -f $(cmt_local_setup)' 0 1 2 15; \
	  $(cmtexe) -tag=$(tags) show setup >>$(cmt_local_setup); \
	  if test ! -f $@; then \
	    mv $(cmt_local_setup) $@; \
	  else \
	    if /usr/bin/diff $(cmt_local_setup) $@ >/dev/null ; then \
	      : ; \
	    else \
	      mv $(cmt_local_setup) $@; \
	    fi; \
	  fi

#	@/bin/echo $@ ok   

config :: checkuses
	@exit 0
checkuses : ;

env.make ::
	printenv >env.make.tmp; $(cmtexe) check files env.make.tmp env.make

ifndef QUICK
all :: build_library_links
	$(echo) "(constituents.make) all done"
endif

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

build_library_links : dirs requirements
	$(echo) "(constituents.make) Rebuilding library links"; \
	if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi; \
	$(build_library_links)

.DEFAULT ::
	$(echo) "(constituents.make) $@: No rule for such target" >&2
#	@echo "#CMT> Warning: $@: Using default commands" >&2; exit

#	@if test "$@" = "$(cmt_lock_setup)"; then \
	#  /bin/rm -f $(cmt_lock_setup); \
	 # touch $(cmt_lock_setup); \
	#fi

#-- end of constituents_header ------
#-- start of group ------

all_groups :: all

all :: $(all_dependencies)  $(all_pre_constituents) $(all_constituents)  $(all_post_constituents)
	$(echo) "all ok."

#	@/bin/echo " all ok."

clean :: allclean

allclean ::  $(all_constituentsclean)
	$(echo) $(all_constituentsclean)
	$(echo) "allclean ok."

#	@echo $(all_constituentsclean)
#	@/bin/echo " allclean ok."

allclean :: makefilesclean

#-- end of group ------
#-- start of group ------

all_groups :: cmt_actions

cmt_actions :: $(cmt_actions_dependencies)  $(cmt_actions_pre_constituents) $(cmt_actions_constituents)  $(cmt_actions_post_constituents)
	$(echo) "cmt_actions ok."

#	@/bin/echo " cmt_actions ok."

clean :: allclean

cmt_actionsclean ::  $(cmt_actions_constituentsclean)
	$(echo) $(cmt_actions_constituentsclean)
	$(echo) "cmt_actionsclean ok."

#	@echo $(cmt_actions_constituentsclean)
#	@/bin/echo " cmt_actionsclean ok."

cmt_actionsclean :: makefilesclean

#-- end of group ------
#-- start of constituent ------

cmt_GammaConv_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GammaConv_has_target_tag

ifdef READONLY
cmt_local_tagfile_GammaConv = /tmp/CMT_$(GammaConv_tag)_GammaConv.make$(cmt_lock_pid)
cmt_final_setup_GammaConv = /tmp/CMT_GammaConv_GammaConvsetup.make
cmt_local_GammaConv_makefile = /tmp/CMT_GammaConv$(cmt_lock_pid).make
else
#cmt_local_tagfile_GammaConv = $(GammaConv_tag)_GammaConv.make
cmt_local_tagfile_GammaConv = $(bin)$(GammaConv_tag)_GammaConv.make
cmt_final_setup_GammaConv = $(bin)GammaConv_GammaConvsetup.make
cmt_local_GammaConv_makefile = $(bin)GammaConv.make
endif

GammaConv_extratags = -tag_add=target_GammaConv

#$(cmt_local_tagfile_GammaConv) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_GammaConv) ::
else
$(cmt_local_tagfile_GammaConv) :
endif
	$(echo) "(constituents.make) Rebuilding setup.make $(cmt_local_tagfile_GammaConv)"
	@if test -f $(cmt_local_tagfile_GammaConv); then /bin/rm -f $(cmt_local_tagfile_GammaConv); fi ; \
	  $(cmtexe) -tag=$(tags) $(GammaConv_extratags) build tag_makefile >>$(cmt_local_tagfile_GammaConv); \
	  if test -f $(cmt_final_setup_GammaConv); then /bin/rm -f $(cmt_final_setup_GammaConv); fi; \
	  $(cmtexe) -tag=$(tags) $(GammaConv_extratags) show setup >>$(cmt_final_setup_GammaConv)
	$(echo) setup.make ok

else

ifdef READONLY
cmt_local_tagfile_GammaConv = /tmp/CMT_$(GammaConv_tag).make$(cmt_lock_pid)
cmt_final_setup_GammaConv = /tmp/CMT_GammaConvsetup.make
cmt_local_GammaConv_makefile = /tmp/CMT_GammaConv$(cmt_lock_pid).make
else
#cmt_local_tagfile_GammaConv = $(GammaConv_tag).make
cmt_local_tagfile_GammaConv = $(bin)$(GammaConv_tag).make
cmt_final_setup_GammaConv = $(bin)GammaConvsetup.make
cmt_local_GammaConv_makefile = $(bin)GammaConv.make
endif

endif

ifndef QUICK
$(cmt_local_GammaConv_makefile) :: $(GammaConv_dependencies) $(cmt_local_tagfile_GammaConv) build_library_links dirs
else
$(cmt_local_GammaConv_makefile) :: $(cmt_local_tagfile_GammaConv)
endif
	$(echo) "(constituents.make) Building GammaConv.make"; \
	  $(cmtexe) -tag=$(tags) $(GammaConv_extratags) build constituent_makefile -out=$(cmt_local_GammaConv_makefile) GammaConv

GammaConv :: $(GammaConv_dependencies) $(cmt_local_GammaConv_makefile)
	$(echo) "(constituents.make) Starting GammaConv"
	@$(MAKE) -f $(cmt_local_GammaConv_makefile) cmt_lock_pid=$${cmt_lock_pid} GammaConv
	$(echo) "(constituents.make) GammaConv done"

clean :: GammaConvclean

GammaConvclean :: $(GammaConvclean_dependencies) ##$(cmt_local_GammaConv_makefile)
	$(echo) "(constituents.make) Starting GammaConvclean"
	@-if test -f $(cmt_local_GammaConv_makefile); then \
	  $(MAKE) -f $(cmt_local_GammaConv_makefile) cmt_lock_pid=$${cmt_lock_pid} GammaConvclean; \
	fi

##	  /bin/rm -f $(cmt_local_GammaConv_makefile) $(bin)GammaConv_dependencies.make

install :: GammaConvinstall

GammaConvinstall :: $(GammaConv_dependencies) $(cmt_local_GammaConv_makefile)
	$(echo) "(constituents.make) Starting install GammaConv"
	@-$(MAKE) -f $(cmt_local_GammaConv_makefile) cmt_lock_pid=$${cmt_lock_pid} install
	$(echo) "(constituents.make) install GammaConv done"

uninstall :: GammaConvuninstall

GammaConvuninstall :: $(cmt_local_GammaConv_makefile)
	$(echo) "(constituents.make) Starting uninstall GammaConv"
	@-$(MAKE) -f $(cmt_local_GammaConv_makefile) cmt_lock_pid=$${cmt_lock_pid} uninstall
	$(echo) "(constituents.make) uninstall GammaConv done"

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GammaConv"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GammaConv done"
endif


#-- end of constituent ------
#-- start of constituent_lock ------

cmt_config_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_config_has_target_tag

ifdef READONLY
cmt_local_tagfile_config = /tmp/CMT_$(GammaConv_tag)_config.make$(cmt_lock_pid)
cmt_final_setup_config = /tmp/CMT_GammaConv_configsetup.make
cmt_local_config_makefile = /tmp/CMT_config$(cmt_lock_pid).make
else
#cmt_local_tagfile_config = $(GammaConv_tag)_config.make
cmt_local_tagfile_config = $(bin)$(GammaConv_tag)_config.make
cmt_final_setup_config = $(bin)GammaConv_configsetup.make
cmt_local_config_makefile = $(bin)config.make
endif

config_extratags = -tag_add=target_config

#$(cmt_local_tagfile_config) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_config) ::
else
$(cmt_local_tagfile_config) :
endif
	$(echo) "(constituents.make) Rebuilding setup.make $(cmt_local_tagfile_config)"
	@if test -f $(cmt_local_tagfile_config); then /bin/rm -f $(cmt_local_tagfile_config); fi ; \
	  $(cmtexe) -tag=$(tags) $(config_extratags) build tag_makefile >>$(cmt_local_tagfile_config); \
	  if test -f $(cmt_final_setup_config); then /bin/rm -f $(cmt_final_setup_config); fi; \
	  $(cmtexe) -tag=$(tags) $(config_extratags) show setup >>$(cmt_final_setup_config)
	$(echo) setup.make ok

else

ifdef READONLY
cmt_local_tagfile_config = /tmp/CMT_$(GammaConv_tag).make$(cmt_lock_pid)
cmt_final_setup_config = /tmp/CMT_GammaConvsetup.make
cmt_local_config_makefile = /tmp/CMT_config$(cmt_lock_pid).make
else
#cmt_local_tagfile_config = $(GammaConv_tag).make
cmt_local_tagfile_config = $(bin)$(GammaConv_tag).make
cmt_final_setup_config = $(bin)GammaConvsetup.make
cmt_local_config_makefile = $(bin)config.make
endif

endif

ifndef QUICK
$(cmt_local_config_makefile) :: $(config_dependencies) $(cmt_local_tagfile_config) build_library_links dirs
else
$(cmt_local_config_makefile) :: $(cmt_local_tagfile_config)
endif
	$(echo) "(constituents.make) Building config.make"; \
	  $(cmtexe) -tag=$(tags) $(config_extratags) build constituent_makefile -out=$(cmt_local_config_makefile) config

config :: $(config_dependencies) $(cmt_local_config_makefile)
	$(echo) "(constituents.make) Creating config${lock_suffix} and Starting config"
	@${lock_command} config${lock_suffix} || exit $$?; \
	  retval=$$?; \
	  trap '${unlock_command} config${lock_suffix}; exit $${retval}' 1 2 15; \
	  $(MAKE) -f $(cmt_local_config_makefile) cmt_lock_pid=$${cmt_lock_pid} config; \
	  retval=$$?; ${unlock_command} config${lock_suffix}; exit $${retval}
	$(echo) "(constituents.make) config done"

clean :: configclean

configclean :: $(configclean_dependencies) ##$(cmt_local_config_makefile)
	$(echo) "(constituents.make) Starting configclean"
	@-if test -f $(cmt_local_config_makefile); then \
	  $(MAKE) -f $(cmt_local_config_makefile) cmt_lock_pid=$${cmt_lock_pid} configclean; \
	fi

##	  /bin/rm -f $(cmt_local_config_makefile) $(bin)config_dependencies.make

install :: configinstall

configinstall :: $(config_dependencies) $(cmt_local_config_makefile)
	$(echo) "(constituents.make) Starting install config"
	@-$(MAKE) -f $(cmt_local_config_makefile) cmt_lock_pid=$${cmt_lock_pid} install
	$(echo) "(constituents.make) install config done"

uninstall :: configuninstall

configuninstall :: $(cmt_local_config_makefile)
	$(echo) "(constituents.make) Starting uninstall config"
	@-$(MAKE) -f $(cmt_local_config_makefile) cmt_lock_pid=$${cmt_lock_pid} uninstall
	$(echo) "(constituents.make) uninstall config done"

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ config"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ config done"
endif


#-- end of constituent_lock ------
#-- start of constituent_lock ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_install_includes_has_target_tag

ifdef READONLY
cmt_local_tagfile_install_includes = /tmp/CMT_$(GammaConv_tag)_install_includes.make$(cmt_lock_pid)
cmt_final_setup_install_includes = /tmp/CMT_GammaConv_install_includessetup.make
cmt_local_install_includes_makefile = /tmp/CMT_install_includes$(cmt_lock_pid).make
else
#cmt_local_tagfile_install_includes = $(GammaConv_tag)_install_includes.make
cmt_local_tagfile_install_includes = $(bin)$(GammaConv_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)GammaConv_install_includessetup.make
cmt_local_install_includes_makefile = $(bin)install_includes.make
endif

install_includes_extratags = -tag_add=target_install_includes

#$(cmt_local_tagfile_install_includes) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_install_includes) ::
else
$(cmt_local_tagfile_install_includes) :
endif
	$(echo) "(constituents.make) Rebuilding setup.make $(cmt_local_tagfile_install_includes)"
	@if test -f $(cmt_local_tagfile_install_includes); then /bin/rm -f $(cmt_local_tagfile_install_includes); fi ; \
	  $(cmtexe) -tag=$(tags) $(install_includes_extratags) build tag_makefile >>$(cmt_local_tagfile_install_includes); \
	  if test -f $(cmt_final_setup_install_includes); then /bin/rm -f $(cmt_final_setup_install_includes); fi; \
	  $(cmtexe) -tag=$(tags) $(install_includes_extratags) show setup >>$(cmt_final_setup_install_includes)
	$(echo) setup.make ok

else

ifdef READONLY
cmt_local_tagfile_install_includes = /tmp/CMT_$(GammaConv_tag).make$(cmt_lock_pid)
cmt_final_setup_install_includes = /tmp/CMT_GammaConvsetup.make
cmt_local_install_includes_makefile = /tmp/CMT_install_includes$(cmt_lock_pid).make
else
#cmt_local_tagfile_install_includes = $(GammaConv_tag).make
cmt_local_tagfile_install_includes = $(bin)$(GammaConv_tag).make
cmt_final_setup_install_includes = $(bin)GammaConvsetup.make
cmt_local_install_includes_makefile = $(bin)install_includes.make
endif

endif

ifndef QUICK
$(cmt_local_install_includes_makefile) :: $(install_includes_dependencies) $(cmt_local_tagfile_install_includes) build_library_links dirs
else
$(cmt_local_install_includes_makefile) :: $(cmt_local_tagfile_install_includes)
endif
	$(echo) "(constituents.make) Building install_includes.make"; \
	  $(cmtexe) -tag=$(tags) $(install_includes_extratags) build constituent_makefile -out=$(cmt_local_install_includes_makefile) install_includes

install_includes :: $(install_includes_dependencies) $(cmt_local_install_includes_makefile)
	$(echo) "(constituents.make) Creating install_includes${lock_suffix} and Starting install_includes"
	@${lock_command} install_includes${lock_suffix} || exit $$?; \
	  retval=$$?; \
	  trap '${unlock_command} install_includes${lock_suffix}; exit $${retval}' 1 2 15; \
	  $(MAKE) -f $(cmt_local_install_includes_makefile) cmt_lock_pid=$${cmt_lock_pid} install_includes; \
	  retval=$$?; ${unlock_command} install_includes${lock_suffix}; exit $${retval}
	$(echo) "(constituents.make) install_includes done"

clean :: install_includesclean

install_includesclean :: $(install_includesclean_dependencies) ##$(cmt_local_install_includes_makefile)
	$(echo) "(constituents.make) Starting install_includesclean"
	@-if test -f $(cmt_local_install_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_includes_makefile) cmt_lock_pid=$${cmt_lock_pid} install_includesclean; \
	fi

##	  /bin/rm -f $(cmt_local_install_includes_makefile) $(bin)install_includes_dependencies.make

install :: install_includesinstall

install_includesinstall :: $(install_includes_dependencies) $(cmt_local_install_includes_makefile)
	$(echo) "(constituents.make) Starting install install_includes"
	@-$(MAKE) -f $(cmt_local_install_includes_makefile) cmt_lock_pid=$${cmt_lock_pid} install
	$(echo) "(constituents.make) install install_includes done"

uninstall :: install_includesuninstall

install_includesuninstall :: $(cmt_local_install_includes_makefile)
	$(echo) "(constituents.make) Starting uninstall install_includes"
	@-$(MAKE) -f $(cmt_local_install_includes_makefile) cmt_lock_pid=$${cmt_lock_pid} uninstall
	$(echo) "(constituents.make) uninstall install_includes done"

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_includes"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_includes done"
endif


#-- end of constituent_lock ------
#-- start of constituent_lock ------

cmt_make_has_target_tag = 1

#--------------------------------------------------------

ifdef cmt_make_has_target_tag

ifdef READONLY
cmt_local_tagfile_make = /tmp/CMT_$(GammaConv_tag)_make.make$(cmt_lock_pid)
cmt_final_setup_make = /tmp/CMT_GammaConv_makesetup.make
cmt_local_make_makefile = /tmp/CMT_make$(cmt_lock_pid).make
else
#cmt_local_tagfile_make = $(GammaConv_tag)_make.make
cmt_local_tagfile_make = $(bin)$(GammaConv_tag)_make.make
cmt_final_setup_make = $(bin)GammaConv_makesetup.make
cmt_local_make_makefile = $(bin)make.make
endif

make_extratags = -tag_add=target_make

#$(cmt_local_tagfile_make) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_make) ::
else
$(cmt_local_tagfile_make) :
endif
	$(echo) "(constituents.make) Rebuilding setup.make $(cmt_local_tagfile_make)"
	@if test -f $(cmt_local_tagfile_make); then /bin/rm -f $(cmt_local_tagfile_make); fi ; \
	  $(cmtexe) -tag=$(tags) $(make_extratags) build tag_makefile >>$(cmt_local_tagfile_make); \
	  if test -f $(cmt_final_setup_make); then /bin/rm -f $(cmt_final_setup_make); fi; \
	  $(cmtexe) -tag=$(tags) $(make_extratags) show setup >>$(cmt_final_setup_make)
	$(echo) setup.make ok

else

ifdef READONLY
cmt_local_tagfile_make = /tmp/CMT_$(GammaConv_tag).make$(cmt_lock_pid)
cmt_final_setup_make = /tmp/CMT_GammaConvsetup.make
cmt_local_make_makefile = /tmp/CMT_make$(cmt_lock_pid).make
else
#cmt_local_tagfile_make = $(GammaConv_tag).make
cmt_local_tagfile_make = $(bin)$(GammaConv_tag).make
cmt_final_setup_make = $(bin)GammaConvsetup.make
cmt_local_make_makefile = $(bin)make.make
endif

endif

ifndef QUICK
$(cmt_local_make_makefile) :: $(make_dependencies) $(cmt_local_tagfile_make) build_library_links dirs
else
$(cmt_local_make_makefile) :: $(cmt_local_tagfile_make)
endif
	$(echo) "(constituents.make) Building make.make"; \
	  $(cmtexe) -tag=$(tags) $(make_extratags) build constituent_makefile -out=$(cmt_local_make_makefile) make

make :: $(make_dependencies) $(cmt_local_make_makefile)
	$(echo) "(constituents.make) Creating make${lock_suffix} and Starting make"
	@${lock_command} make${lock_suffix} || exit $$?; \
	  retval=$$?; \
	  trap '${unlock_command} make${lock_suffix}; exit $${retval}' 1 2 15; \
	  $(MAKE) -f $(cmt_local_make_makefile) cmt_lock_pid=$${cmt_lock_pid} make; \
	  retval=$$?; ${unlock_command} make${lock_suffix}; exit $${retval}
	$(echo) "(constituents.make) make done"

clean :: makeclean

makeclean :: $(makeclean_dependencies) ##$(cmt_local_make_makefile)
	$(echo) "(constituents.make) Starting makeclean"
	@-if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) cmt_lock_pid=$${cmt_lock_pid} makeclean; \
	fi

##	  /bin/rm -f $(cmt_local_make_makefile) $(bin)make_dependencies.make

install :: makeinstall

makeinstall :: $(make_dependencies) $(cmt_local_make_makefile)
	$(echo) "(constituents.make) Starting install make"
	@-$(MAKE) -f $(cmt_local_make_makefile) cmt_lock_pid=$${cmt_lock_pid} install
	$(echo) "(constituents.make) install make done"

uninstall :: makeuninstall

makeuninstall :: $(cmt_local_make_makefile)
	$(echo) "(constituents.make) Starting uninstall make"
	@-$(MAKE) -f $(cmt_local_make_makefile) cmt_lock_pid=$${cmt_lock_pid} uninstall
	$(echo) "(constituents.make) uninstall make done"

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ make"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ make done"
endif


#-- end of constituent_lock ------
#-- start of constituent_lock ------

cmt_CompilePython_has_target_tag = 1

#--------------------------------------------------------

ifdef cmt_CompilePython_has_target_tag

ifdef READONLY
cmt_local_tagfile_CompilePython = /tmp/CMT_$(GammaConv_tag)_CompilePython.make$(cmt_lock_pid)
cmt_final_setup_CompilePython = /tmp/CMT_GammaConv_CompilePythonsetup.make
cmt_local_CompilePython_makefile = /tmp/CMT_CompilePython$(cmt_lock_pid).make
else
#cmt_local_tagfile_CompilePython = $(GammaConv_tag)_CompilePython.make
cmt_local_tagfile_CompilePython = $(bin)$(GammaConv_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)GammaConv_CompilePythonsetup.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make
endif

CompilePython_extratags = -tag_add=target_CompilePython

#$(cmt_local_tagfile_CompilePython) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_CompilePython) ::
else
$(cmt_local_tagfile_CompilePython) :
endif
	$(echo) "(constituents.make) Rebuilding setup.make $(cmt_local_tagfile_CompilePython)"
	@if test -f $(cmt_local_tagfile_CompilePython); then /bin/rm -f $(cmt_local_tagfile_CompilePython); fi ; \
	  $(cmtexe) -tag=$(tags) $(CompilePython_extratags) build tag_makefile >>$(cmt_local_tagfile_CompilePython); \
	  if test -f $(cmt_final_setup_CompilePython); then /bin/rm -f $(cmt_final_setup_CompilePython); fi; \
	  $(cmtexe) -tag=$(tags) $(CompilePython_extratags) show setup >>$(cmt_final_setup_CompilePython)
	$(echo) setup.make ok

else

ifdef READONLY
cmt_local_tagfile_CompilePython = /tmp/CMT_$(GammaConv_tag).make$(cmt_lock_pid)
cmt_final_setup_CompilePython = /tmp/CMT_GammaConvsetup.make
cmt_local_CompilePython_makefile = /tmp/CMT_CompilePython$(cmt_lock_pid).make
else
#cmt_local_tagfile_CompilePython = $(GammaConv_tag).make
cmt_local_tagfile_CompilePython = $(bin)$(GammaConv_tag).make
cmt_final_setup_CompilePython = $(bin)GammaConvsetup.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make
endif

endif

ifndef QUICK
$(cmt_local_CompilePython_makefile) :: $(CompilePython_dependencies) $(cmt_local_tagfile_CompilePython) build_library_links dirs
else
$(cmt_local_CompilePython_makefile) :: $(cmt_local_tagfile_CompilePython)
endif
	$(echo) "(constituents.make) Building CompilePython.make"; \
	  $(cmtexe) -tag=$(tags) $(CompilePython_extratags) build constituent_makefile -out=$(cmt_local_CompilePython_makefile) CompilePython

CompilePython :: $(CompilePython_dependencies) $(cmt_local_CompilePython_makefile)
	$(echo) "(constituents.make) Creating CompilePython${lock_suffix} and Starting CompilePython"
	@${lock_command} CompilePython${lock_suffix} || exit $$?; \
	  retval=$$?; \
	  trap '${unlock_command} CompilePython${lock_suffix}; exit $${retval}' 1 2 15; \
	  $(MAKE) -f $(cmt_local_CompilePython_makefile) cmt_lock_pid=$${cmt_lock_pid} CompilePython; \
	  retval=$$?; ${unlock_command} CompilePython${lock_suffix}; exit $${retval}
	$(echo) "(constituents.make) CompilePython done"

clean :: CompilePythonclean

CompilePythonclean :: $(CompilePythonclean_dependencies) ##$(cmt_local_CompilePython_makefile)
	$(echo) "(constituents.make) Starting CompilePythonclean"
	@-if test -f $(cmt_local_CompilePython_makefile); then \
	  $(MAKE) -f $(cmt_local_CompilePython_makefile) cmt_lock_pid=$${cmt_lock_pid} CompilePythonclean; \
	fi

##	  /bin/rm -f $(cmt_local_CompilePython_makefile) $(bin)CompilePython_dependencies.make

install :: CompilePythoninstall

CompilePythoninstall :: $(CompilePython_dependencies) $(cmt_local_CompilePython_makefile)
	$(echo) "(constituents.make) Starting install CompilePython"
	@-$(MAKE) -f $(cmt_local_CompilePython_makefile) cmt_lock_pid=$${cmt_lock_pid} install
	$(echo) "(constituents.make) install CompilePython done"

uninstall :: CompilePythonuninstall

CompilePythonuninstall :: $(cmt_local_CompilePython_makefile)
	$(echo) "(constituents.make) Starting uninstall CompilePython"
	@-$(MAKE) -f $(cmt_local_CompilePython_makefile) cmt_lock_pid=$${cmt_lock_pid} uninstall
	$(echo) "(constituents.make) uninstall CompilePython done"

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ CompilePython"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ CompilePython done"
endif


#-- end of constituent_lock ------
#-- start of constituent_lock ------

cmt_qmtest_run_has_target_tag = 1

#--------------------------------------------------------

ifdef cmt_qmtest_run_has_target_tag

ifdef READONLY
cmt_local_tagfile_qmtest_run = /tmp/CMT_$(GammaConv_tag)_qmtest_run.make$(cmt_lock_pid)
cmt_final_setup_qmtest_run = /tmp/CMT_GammaConv_qmtest_runsetup.make
cmt_local_qmtest_run_makefile = /tmp/CMT_qmtest_run$(cmt_lock_pid).make
else
#cmt_local_tagfile_qmtest_run = $(GammaConv_tag)_qmtest_run.make
cmt_local_tagfile_qmtest_run = $(bin)$(GammaConv_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)GammaConv_qmtest_runsetup.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make
endif

qmtest_run_extratags = -tag_add=target_qmtest_run

#$(cmt_local_tagfile_qmtest_run) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_qmtest_run) ::
else
$(cmt_local_tagfile_qmtest_run) :
endif
	$(echo) "(constituents.make) Rebuilding setup.make $(cmt_local_tagfile_qmtest_run)"
	@if test -f $(cmt_local_tagfile_qmtest_run); then /bin/rm -f $(cmt_local_tagfile_qmtest_run); fi ; \
	  $(cmtexe) -tag=$(tags) $(qmtest_run_extratags) build tag_makefile >>$(cmt_local_tagfile_qmtest_run); \
	  if test -f $(cmt_final_setup_qmtest_run); then /bin/rm -f $(cmt_final_setup_qmtest_run); fi; \
	  $(cmtexe) -tag=$(tags) $(qmtest_run_extratags) show setup >>$(cmt_final_setup_qmtest_run)
	$(echo) setup.make ok

else

ifdef READONLY
cmt_local_tagfile_qmtest_run = /tmp/CMT_$(GammaConv_tag).make$(cmt_lock_pid)
cmt_final_setup_qmtest_run = /tmp/CMT_GammaConvsetup.make
cmt_local_qmtest_run_makefile = /tmp/CMT_qmtest_run$(cmt_lock_pid).make
else
#cmt_local_tagfile_qmtest_run = $(GammaConv_tag).make
cmt_local_tagfile_qmtest_run = $(bin)$(GammaConv_tag).make
cmt_final_setup_qmtest_run = $(bin)GammaConvsetup.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make
endif

endif

ifndef QUICK
$(cmt_local_qmtest_run_makefile) :: $(qmtest_run_dependencies) $(cmt_local_tagfile_qmtest_run) build_library_links dirs
else
$(cmt_local_qmtest_run_makefile) :: $(cmt_local_tagfile_qmtest_run)
endif
	$(echo) "(constituents.make) Building qmtest_run.make"; \
	  $(cmtexe) -tag=$(tags) $(qmtest_run_extratags) build constituent_makefile -out=$(cmt_local_qmtest_run_makefile) qmtest_run

qmtest_run :: $(qmtest_run_dependencies) $(cmt_local_qmtest_run_makefile)
	$(echo) "(constituents.make) Creating qmtest_run${lock_suffix} and Starting qmtest_run"
	@${lock_command} qmtest_run${lock_suffix} || exit $$?; \
	  retval=$$?; \
	  trap '${unlock_command} qmtest_run${lock_suffix}; exit $${retval}' 1 2 15; \
	  $(MAKE) -f $(cmt_local_qmtest_run_makefile) cmt_lock_pid=$${cmt_lock_pid} qmtest_run; \
	  retval=$$?; ${unlock_command} qmtest_run${lock_suffix}; exit $${retval}
	$(echo) "(constituents.make) qmtest_run done"

clean :: qmtest_runclean

qmtest_runclean :: $(qmtest_runclean_dependencies) ##$(cmt_local_qmtest_run_makefile)
	$(echo) "(constituents.make) Starting qmtest_runclean"
	@-if test -f $(cmt_local_qmtest_run_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_run_makefile) cmt_lock_pid=$${cmt_lock_pid} qmtest_runclean; \
	fi

##	  /bin/rm -f $(cmt_local_qmtest_run_makefile) $(bin)qmtest_run_dependencies.make

install :: qmtest_runinstall

qmtest_runinstall :: $(qmtest_run_dependencies) $(cmt_local_qmtest_run_makefile)
	$(echo) "(constituents.make) Starting install qmtest_run"
	@-$(MAKE) -f $(cmt_local_qmtest_run_makefile) cmt_lock_pid=$${cmt_lock_pid} install
	$(echo) "(constituents.make) install qmtest_run done"

uninstall :: qmtest_rununinstall

qmtest_rununinstall :: $(cmt_local_qmtest_run_makefile)
	$(echo) "(constituents.make) Starting uninstall qmtest_run"
	@-$(MAKE) -f $(cmt_local_qmtest_run_makefile) cmt_lock_pid=$${cmt_lock_pid} uninstall
	$(echo) "(constituents.make) uninstall qmtest_run done"

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ qmtest_run"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ qmtest_run done"
endif


#-- end of constituent_lock ------
#-- start of constituent_lock ------

cmt_qmtest_summarize_has_target_tag = 1

#--------------------------------------------------------

ifdef cmt_qmtest_summarize_has_target_tag

ifdef READONLY
cmt_local_tagfile_qmtest_summarize = /tmp/CMT_$(GammaConv_tag)_qmtest_summarize.make$(cmt_lock_pid)
cmt_final_setup_qmtest_summarize = /tmp/CMT_GammaConv_qmtest_summarizesetup.make
cmt_local_qmtest_summarize_makefile = /tmp/CMT_qmtest_summarize$(cmt_lock_pid).make
else
#cmt_local_tagfile_qmtest_summarize = $(GammaConv_tag)_qmtest_summarize.make
cmt_local_tagfile_qmtest_summarize = $(bin)$(GammaConv_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)GammaConv_qmtest_summarizesetup.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make
endif

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

#$(cmt_local_tagfile_qmtest_summarize) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_qmtest_summarize) ::
else
$(cmt_local_tagfile_qmtest_summarize) :
endif
	$(echo) "(constituents.make) Rebuilding setup.make $(cmt_local_tagfile_qmtest_summarize)"
	@if test -f $(cmt_local_tagfile_qmtest_summarize); then /bin/rm -f $(cmt_local_tagfile_qmtest_summarize); fi ; \
	  $(cmtexe) -tag=$(tags) $(qmtest_summarize_extratags) build tag_makefile >>$(cmt_local_tagfile_qmtest_summarize); \
	  if test -f $(cmt_final_setup_qmtest_summarize); then /bin/rm -f $(cmt_final_setup_qmtest_summarize); fi; \
	  $(cmtexe) -tag=$(tags) $(qmtest_summarize_extratags) show setup >>$(cmt_final_setup_qmtest_summarize)
	$(echo) setup.make ok

else

ifdef READONLY
cmt_local_tagfile_qmtest_summarize = /tmp/CMT_$(GammaConv_tag).make$(cmt_lock_pid)
cmt_final_setup_qmtest_summarize = /tmp/CMT_GammaConvsetup.make
cmt_local_qmtest_summarize_makefile = /tmp/CMT_qmtest_summarize$(cmt_lock_pid).make
else
#cmt_local_tagfile_qmtest_summarize = $(GammaConv_tag).make
cmt_local_tagfile_qmtest_summarize = $(bin)$(GammaConv_tag).make
cmt_final_setup_qmtest_summarize = $(bin)GammaConvsetup.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make
endif

endif

ifndef QUICK
$(cmt_local_qmtest_summarize_makefile) :: $(qmtest_summarize_dependencies) $(cmt_local_tagfile_qmtest_summarize) build_library_links dirs
else
$(cmt_local_qmtest_summarize_makefile) :: $(cmt_local_tagfile_qmtest_summarize)
endif
	$(echo) "(constituents.make) Building qmtest_summarize.make"; \
	  $(cmtexe) -tag=$(tags) $(qmtest_summarize_extratags) build constituent_makefile -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize

qmtest_summarize :: $(qmtest_summarize_dependencies) $(cmt_local_qmtest_summarize_makefile)
	$(echo) "(constituents.make) Creating qmtest_summarize${lock_suffix} and Starting qmtest_summarize"
	@${lock_command} qmtest_summarize${lock_suffix} || exit $$?; \
	  retval=$$?; \
	  trap '${unlock_command} qmtest_summarize${lock_suffix}; exit $${retval}' 1 2 15; \
	  $(MAKE) -f $(cmt_local_qmtest_summarize_makefile) cmt_lock_pid=$${cmt_lock_pid} qmtest_summarize; \
	  retval=$$?; ${unlock_command} qmtest_summarize${lock_suffix}; exit $${retval}
	$(echo) "(constituents.make) qmtest_summarize done"

clean :: qmtest_summarizeclean

qmtest_summarizeclean :: $(qmtest_summarizeclean_dependencies) ##$(cmt_local_qmtest_summarize_makefile)
	$(echo) "(constituents.make) Starting qmtest_summarizeclean"
	@-if test -f $(cmt_local_qmtest_summarize_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_summarize_makefile) cmt_lock_pid=$${cmt_lock_pid} qmtest_summarizeclean; \
	fi

##	  /bin/rm -f $(cmt_local_qmtest_summarize_makefile) $(bin)qmtest_summarize_dependencies.make

install :: qmtest_summarizeinstall

qmtest_summarizeinstall :: $(qmtest_summarize_dependencies) $(cmt_local_qmtest_summarize_makefile)
	$(echo) "(constituents.make) Starting install qmtest_summarize"
	@-$(MAKE) -f $(cmt_local_qmtest_summarize_makefile) cmt_lock_pid=$${cmt_lock_pid} install
	$(echo) "(constituents.make) install qmtest_summarize done"

uninstall :: qmtest_summarizeuninstall

qmtest_summarizeuninstall :: $(cmt_local_qmtest_summarize_makefile)
	$(echo) "(constituents.make) Starting uninstall qmtest_summarize"
	@-$(MAKE) -f $(cmt_local_qmtest_summarize_makefile) cmt_lock_pid=$${cmt_lock_pid} uninstall
	$(echo) "(constituents.make) uninstall qmtest_summarize done"

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ qmtest_summarize"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ qmtest_summarize done"
endif


#-- end of constituent_lock ------
#-- start of constituent_lock ------

cmt_TestPackage_has_target_tag = 1

#--------------------------------------------------------

ifdef cmt_TestPackage_has_target_tag

ifdef READONLY
cmt_local_tagfile_TestPackage = /tmp/CMT_$(GammaConv_tag)_TestPackage.make$(cmt_lock_pid)
cmt_final_setup_TestPackage = /tmp/CMT_GammaConv_TestPackagesetup.make
cmt_local_TestPackage_makefile = /tmp/CMT_TestPackage$(cmt_lock_pid).make
else
#cmt_local_tagfile_TestPackage = $(GammaConv_tag)_TestPackage.make
cmt_local_tagfile_TestPackage = $(bin)$(GammaConv_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)GammaConv_TestPackagesetup.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make
endif

TestPackage_extratags = -tag_add=target_TestPackage

#$(cmt_local_tagfile_TestPackage) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_TestPackage) ::
else
$(cmt_local_tagfile_TestPackage) :
endif
	$(echo) "(constituents.make) Rebuilding setup.make $(cmt_local_tagfile_TestPackage)"
	@if test -f $(cmt_local_tagfile_TestPackage); then /bin/rm -f $(cmt_local_tagfile_TestPackage); fi ; \
	  $(cmtexe) -tag=$(tags) $(TestPackage_extratags) build tag_makefile >>$(cmt_local_tagfile_TestPackage); \
	  if test -f $(cmt_final_setup_TestPackage); then /bin/rm -f $(cmt_final_setup_TestPackage); fi; \
	  $(cmtexe) -tag=$(tags) $(TestPackage_extratags) show setup >>$(cmt_final_setup_TestPackage)
	$(echo) setup.make ok

else

ifdef READONLY
cmt_local_tagfile_TestPackage = /tmp/CMT_$(GammaConv_tag).make$(cmt_lock_pid)
cmt_final_setup_TestPackage = /tmp/CMT_GammaConvsetup.make
cmt_local_TestPackage_makefile = /tmp/CMT_TestPackage$(cmt_lock_pid).make
else
#cmt_local_tagfile_TestPackage = $(GammaConv_tag).make
cmt_local_tagfile_TestPackage = $(bin)$(GammaConv_tag).make
cmt_final_setup_TestPackage = $(bin)GammaConvsetup.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make
endif

endif

ifndef QUICK
$(cmt_local_TestPackage_makefile) :: $(TestPackage_dependencies) $(cmt_local_tagfile_TestPackage) build_library_links dirs
else
$(cmt_local_TestPackage_makefile) :: $(cmt_local_tagfile_TestPackage)
endif
	$(echo) "(constituents.make) Building TestPackage.make"; \
	  $(cmtexe) -tag=$(tags) $(TestPackage_extratags) build constituent_makefile -out=$(cmt_local_TestPackage_makefile) TestPackage

TestPackage :: $(TestPackage_dependencies) $(cmt_local_TestPackage_makefile)
	$(echo) "(constituents.make) Creating TestPackage${lock_suffix} and Starting TestPackage"
	@${lock_command} TestPackage${lock_suffix} || exit $$?; \
	  retval=$$?; \
	  trap '${unlock_command} TestPackage${lock_suffix}; exit $${retval}' 1 2 15; \
	  $(MAKE) -f $(cmt_local_TestPackage_makefile) cmt_lock_pid=$${cmt_lock_pid} TestPackage; \
	  retval=$$?; ${unlock_command} TestPackage${lock_suffix}; exit $${retval}
	$(echo) "(constituents.make) TestPackage done"

clean :: TestPackageclean

TestPackageclean :: $(TestPackageclean_dependencies) ##$(cmt_local_TestPackage_makefile)
	$(echo) "(constituents.make) Starting TestPackageclean"
	@-if test -f $(cmt_local_TestPackage_makefile); then \
	  $(MAKE) -f $(cmt_local_TestPackage_makefile) cmt_lock_pid=$${cmt_lock_pid} TestPackageclean; \
	fi

##	  /bin/rm -f $(cmt_local_TestPackage_makefile) $(bin)TestPackage_dependencies.make

install :: TestPackageinstall

TestPackageinstall :: $(TestPackage_dependencies) $(cmt_local_TestPackage_makefile)
	$(echo) "(constituents.make) Starting install TestPackage"
	@-$(MAKE) -f $(cmt_local_TestPackage_makefile) cmt_lock_pid=$${cmt_lock_pid} install
	$(echo) "(constituents.make) install TestPackage done"

uninstall :: TestPackageuninstall

TestPackageuninstall :: $(cmt_local_TestPackage_makefile)
	$(echo) "(constituents.make) Starting uninstall TestPackage"
	@-$(MAKE) -f $(cmt_local_TestPackage_makefile) cmt_lock_pid=$${cmt_lock_pid} uninstall
	$(echo) "(constituents.make) uninstall TestPackage done"

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ TestPackage"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ TestPackage done"
endif


#-- end of constituent_lock ------
#-- start of constituent_lock ------

cmt_TestProject_has_target_tag = 1

#--------------------------------------------------------

ifdef cmt_TestProject_has_target_tag

ifdef READONLY
cmt_local_tagfile_TestProject = /tmp/CMT_$(GammaConv_tag)_TestProject.make$(cmt_lock_pid)
cmt_final_setup_TestProject = /tmp/CMT_GammaConv_TestProjectsetup.make
cmt_local_TestProject_makefile = /tmp/CMT_TestProject$(cmt_lock_pid).make
else
#cmt_local_tagfile_TestProject = $(GammaConv_tag)_TestProject.make
cmt_local_tagfile_TestProject = $(bin)$(GammaConv_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)GammaConv_TestProjectsetup.make
cmt_local_TestProject_makefile = $(bin)TestProject.make
endif

TestProject_extratags = -tag_add=target_TestProject

#$(cmt_local_tagfile_TestProject) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_TestProject) ::
else
$(cmt_local_tagfile_TestProject) :
endif
	$(echo) "(constituents.make) Rebuilding setup.make $(cmt_local_tagfile_TestProject)"
	@if test -f $(cmt_local_tagfile_TestProject); then /bin/rm -f $(cmt_local_tagfile_TestProject); fi ; \
	  $(cmtexe) -tag=$(tags) $(TestProject_extratags) build tag_makefile >>$(cmt_local_tagfile_TestProject); \
	  if test -f $(cmt_final_setup_TestProject); then /bin/rm -f $(cmt_final_setup_TestProject); fi; \
	  $(cmtexe) -tag=$(tags) $(TestProject_extratags) show setup >>$(cmt_final_setup_TestProject)
	$(echo) setup.make ok

else

ifdef READONLY
cmt_local_tagfile_TestProject = /tmp/CMT_$(GammaConv_tag).make$(cmt_lock_pid)
cmt_final_setup_TestProject = /tmp/CMT_GammaConvsetup.make
cmt_local_TestProject_makefile = /tmp/CMT_TestProject$(cmt_lock_pid).make
else
#cmt_local_tagfile_TestProject = $(GammaConv_tag).make
cmt_local_tagfile_TestProject = $(bin)$(GammaConv_tag).make
cmt_final_setup_TestProject = $(bin)GammaConvsetup.make
cmt_local_TestProject_makefile = $(bin)TestProject.make
endif

endif

ifndef QUICK
$(cmt_local_TestProject_makefile) :: $(TestProject_dependencies) $(cmt_local_tagfile_TestProject) build_library_links dirs
else
$(cmt_local_TestProject_makefile) :: $(cmt_local_tagfile_TestProject)
endif
	$(echo) "(constituents.make) Building TestProject.make"; \
	  $(cmtexe) -tag=$(tags) $(TestProject_extratags) build constituent_makefile -out=$(cmt_local_TestProject_makefile) TestProject

TestProject :: $(TestProject_dependencies) $(cmt_local_TestProject_makefile)
	$(echo) "(constituents.make) Creating TestProject${lock_suffix} and Starting TestProject"
	@${lock_command} TestProject${lock_suffix} || exit $$?; \
	  retval=$$?; \
	  trap '${unlock_command} TestProject${lock_suffix}; exit $${retval}' 1 2 15; \
	  $(MAKE) -f $(cmt_local_TestProject_makefile) cmt_lock_pid=$${cmt_lock_pid} TestProject; \
	  retval=$$?; ${unlock_command} TestProject${lock_suffix}; exit $${retval}
	$(echo) "(constituents.make) TestProject done"

clean :: TestProjectclean

TestProjectclean :: $(TestProjectclean_dependencies) ##$(cmt_local_TestProject_makefile)
	$(echo) "(constituents.make) Starting TestProjectclean"
	@-if test -f $(cmt_local_TestProject_makefile); then \
	  $(MAKE) -f $(cmt_local_TestProject_makefile) cmt_lock_pid=$${cmt_lock_pid} TestProjectclean; \
	fi

##	  /bin/rm -f $(cmt_local_TestProject_makefile) $(bin)TestProject_dependencies.make

install :: TestProjectinstall

TestProjectinstall :: $(TestProject_dependencies) $(cmt_local_TestProject_makefile)
	$(echo) "(constituents.make) Starting install TestProject"
	@-$(MAKE) -f $(cmt_local_TestProject_makefile) cmt_lock_pid=$${cmt_lock_pid} install
	$(echo) "(constituents.make) install TestProject done"

uninstall :: TestProjectuninstall

TestProjectuninstall :: $(cmt_local_TestProject_makefile)
	$(echo) "(constituents.make) Starting uninstall TestProject"
	@-$(MAKE) -f $(cmt_local_TestProject_makefile) cmt_lock_pid=$${cmt_lock_pid} uninstall
	$(echo) "(constituents.make) uninstall TestProject done"

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ TestProject"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ TestProject done"
endif


#-- end of constituent_lock ------
#-- start of constituent_lock ------

cmt_new_rootsys_has_target_tag = 1

#--------------------------------------------------------

ifdef cmt_new_rootsys_has_target_tag

ifdef READONLY
cmt_local_tagfile_new_rootsys = /tmp/CMT_$(GammaConv_tag)_new_rootsys.make$(cmt_lock_pid)
cmt_final_setup_new_rootsys = /tmp/CMT_GammaConv_new_rootsyssetup.make
cmt_local_new_rootsys_makefile = /tmp/CMT_new_rootsys$(cmt_lock_pid).make
else
#cmt_local_tagfile_new_rootsys = $(GammaConv_tag)_new_rootsys.make
cmt_local_tagfile_new_rootsys = $(bin)$(GammaConv_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)GammaConv_new_rootsyssetup.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make
endif

new_rootsys_extratags = -tag_add=target_new_rootsys

#$(cmt_local_tagfile_new_rootsys) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_new_rootsys) ::
else
$(cmt_local_tagfile_new_rootsys) :
endif
	$(echo) "(constituents.make) Rebuilding setup.make $(cmt_local_tagfile_new_rootsys)"
	@if test -f $(cmt_local_tagfile_new_rootsys); then /bin/rm -f $(cmt_local_tagfile_new_rootsys); fi ; \
	  $(cmtexe) -tag=$(tags) $(new_rootsys_extratags) build tag_makefile >>$(cmt_local_tagfile_new_rootsys); \
	  if test -f $(cmt_final_setup_new_rootsys); then /bin/rm -f $(cmt_final_setup_new_rootsys); fi; \
	  $(cmtexe) -tag=$(tags) $(new_rootsys_extratags) show setup >>$(cmt_final_setup_new_rootsys)
	$(echo) setup.make ok

else

ifdef READONLY
cmt_local_tagfile_new_rootsys = /tmp/CMT_$(GammaConv_tag).make$(cmt_lock_pid)
cmt_final_setup_new_rootsys = /tmp/CMT_GammaConvsetup.make
cmt_local_new_rootsys_makefile = /tmp/CMT_new_rootsys$(cmt_lock_pid).make
else
#cmt_local_tagfile_new_rootsys = $(GammaConv_tag).make
cmt_local_tagfile_new_rootsys = $(bin)$(GammaConv_tag).make
cmt_final_setup_new_rootsys = $(bin)GammaConvsetup.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make
endif

endif

ifndef QUICK
$(cmt_local_new_rootsys_makefile) :: $(new_rootsys_dependencies) $(cmt_local_tagfile_new_rootsys) build_library_links dirs
else
$(cmt_local_new_rootsys_makefile) :: $(cmt_local_tagfile_new_rootsys)
endif
	$(echo) "(constituents.make) Building new_rootsys.make"; \
	  $(cmtexe) -tag=$(tags) $(new_rootsys_extratags) build constituent_makefile -out=$(cmt_local_new_rootsys_makefile) new_rootsys

new_rootsys :: $(new_rootsys_dependencies) $(cmt_local_new_rootsys_makefile)
	$(echo) "(constituents.make) Creating new_rootsys${lock_suffix} and Starting new_rootsys"
	@${lock_command} new_rootsys${lock_suffix} || exit $$?; \
	  retval=$$?; \
	  trap '${unlock_command} new_rootsys${lock_suffix}; exit $${retval}' 1 2 15; \
	  $(MAKE) -f $(cmt_local_new_rootsys_makefile) cmt_lock_pid=$${cmt_lock_pid} new_rootsys; \
	  retval=$$?; ${unlock_command} new_rootsys${lock_suffix}; exit $${retval}
	$(echo) "(constituents.make) new_rootsys done"

clean :: new_rootsysclean

new_rootsysclean :: $(new_rootsysclean_dependencies) ##$(cmt_local_new_rootsys_makefile)
	$(echo) "(constituents.make) Starting new_rootsysclean"
	@-if test -f $(cmt_local_new_rootsys_makefile); then \
	  $(MAKE) -f $(cmt_local_new_rootsys_makefile) cmt_lock_pid=$${cmt_lock_pid} new_rootsysclean; \
	fi

##	  /bin/rm -f $(cmt_local_new_rootsys_makefile) $(bin)new_rootsys_dependencies.make

install :: new_rootsysinstall

new_rootsysinstall :: $(new_rootsys_dependencies) $(cmt_local_new_rootsys_makefile)
	$(echo) "(constituents.make) Starting install new_rootsys"
	@-$(MAKE) -f $(cmt_local_new_rootsys_makefile) cmt_lock_pid=$${cmt_lock_pid} install
	$(echo) "(constituents.make) install new_rootsys done"

uninstall :: new_rootsysuninstall

new_rootsysuninstall :: $(cmt_local_new_rootsys_makefile)
	$(echo) "(constituents.make) Starting uninstall new_rootsys"
	@-$(MAKE) -f $(cmt_local_new_rootsys_makefile) cmt_lock_pid=$${cmt_lock_pid} uninstall
	$(echo) "(constituents.make) uninstall new_rootsys done"

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ new_rootsys"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ new_rootsys done"
endif


#-- end of constituent_lock ------
#-- start of constituent_lock ------

cmt_DatabaseSvc_check_install_scripts_has_target_tag = 1

#--------------------------------------------------------

ifdef cmt_DatabaseSvc_check_install_scripts_has_target_tag

ifdef READONLY
cmt_local_tagfile_DatabaseSvc_check_install_scripts = /tmp/CMT_$(GammaConv_tag)_DatabaseSvc_check_install_scripts.make$(cmt_lock_pid)
cmt_final_setup_DatabaseSvc_check_install_scripts = /tmp/CMT_GammaConv_DatabaseSvc_check_install_scriptssetup.make
cmt_local_DatabaseSvc_check_install_scripts_makefile = /tmp/CMT_DatabaseSvc_check_install_scripts$(cmt_lock_pid).make
else
#cmt_local_tagfile_DatabaseSvc_check_install_scripts = $(GammaConv_tag)_DatabaseSvc_check_install_scripts.make
cmt_local_tagfile_DatabaseSvc_check_install_scripts = $(bin)$(GammaConv_tag)_DatabaseSvc_check_install_scripts.make
cmt_final_setup_DatabaseSvc_check_install_scripts = $(bin)GammaConv_DatabaseSvc_check_install_scriptssetup.make
cmt_local_DatabaseSvc_check_install_scripts_makefile = $(bin)DatabaseSvc_check_install_scripts.make
endif

DatabaseSvc_check_install_scripts_extratags = -tag_add=target_DatabaseSvc_check_install_scripts

#$(cmt_local_tagfile_DatabaseSvc_check_install_scripts) : $(cmt_lock_setup)
ifndef QUICK
$(cmt_local_tagfile_DatabaseSvc_check_install_scripts) ::
else
$(cmt_local_tagfile_DatabaseSvc_check_install_scripts) :
endif
	$(echo) "(constituents.make) Rebuilding setup.make $(cmt_local_tagfile_DatabaseSvc_check_install_scripts)"
	@if test -f $(cmt_local_tagfile_DatabaseSvc_check_install_scripts); then /bin/rm -f $(cmt_local_tagfile_DatabaseSvc_check_install_scripts); fi ; \
	  $(cmtexe) -tag=$(tags) $(DatabaseSvc_check_install_scripts_extratags) build tag_makefile >>$(cmt_local_tagfile_DatabaseSvc_check_install_scripts); \
	  if test -f $(cmt_final_setup_DatabaseSvc_check_install_scripts); then /bin/rm -f $(cmt_final_setup_DatabaseSvc_check_install_scripts); fi; \
	  $(cmtexe) -tag=$(tags) $(DatabaseSvc_check_install_scripts_extratags) show setup >>$(cmt_final_setup_DatabaseSvc_check_install_scripts)
	$(echo) setup.make ok

else

ifdef READONLY
cmt_local_tagfile_DatabaseSvc_check_install_scripts = /tmp/CMT_$(GammaConv_tag).make$(cmt_lock_pid)
cmt_final_setup_DatabaseSvc_check_install_scripts = /tmp/CMT_GammaConvsetup.make
cmt_local_DatabaseSvc_check_install_scripts_makefile = /tmp/CMT_DatabaseSvc_check_install_scripts$(cmt_lock_pid).make
else
#cmt_local_tagfile_DatabaseSvc_check_install_scripts = $(GammaConv_tag).make
cmt_local_tagfile_DatabaseSvc_check_install_scripts = $(bin)$(GammaConv_tag).make
cmt_final_setup_DatabaseSvc_check_install_scripts = $(bin)GammaConvsetup.make
cmt_local_DatabaseSvc_check_install_scripts_makefile = $(bin)DatabaseSvc_check_install_scripts.make
endif

endif

ifndef QUICK
$(cmt_local_DatabaseSvc_check_install_scripts_makefile) :: $(DatabaseSvc_check_install_scripts_dependencies) $(cmt_local_tagfile_DatabaseSvc_check_install_scripts) build_library_links dirs
else
$(cmt_local_DatabaseSvc_check_install_scripts_makefile) :: $(cmt_local_tagfile_DatabaseSvc_check_install_scripts)
endif
	$(echo) "(constituents.make) Building DatabaseSvc_check_install_scripts.make"; \
	  $(cmtexe) -tag=$(tags) $(DatabaseSvc_check_install_scripts_extratags) build constituent_makefile -out=$(cmt_local_DatabaseSvc_check_install_scripts_makefile) DatabaseSvc_check_install_scripts

DatabaseSvc_check_install_scripts :: $(DatabaseSvc_check_install_scripts_dependencies) $(cmt_local_DatabaseSvc_check_install_scripts_makefile)
	$(echo) "(constituents.make) Creating DatabaseSvc_check_install_scripts${lock_suffix} and Starting DatabaseSvc_check_install_scripts"
	@${lock_command} DatabaseSvc_check_install_scripts${lock_suffix} || exit $$?; \
	  retval=$$?; \
	  trap '${unlock_command} DatabaseSvc_check_install_scripts${lock_suffix}; exit $${retval}' 1 2 15; \
	  $(MAKE) -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile) cmt_lock_pid=$${cmt_lock_pid} DatabaseSvc_check_install_scripts; \
	  retval=$$?; ${unlock_command} DatabaseSvc_check_install_scripts${lock_suffix}; exit $${retval}
	$(echo) "(constituents.make) DatabaseSvc_check_install_scripts done"

clean :: DatabaseSvc_check_install_scriptsclean

DatabaseSvc_check_install_scriptsclean :: $(DatabaseSvc_check_install_scriptsclean_dependencies) ##$(cmt_local_DatabaseSvc_check_install_scripts_makefile)
	$(echo) "(constituents.make) Starting DatabaseSvc_check_install_scriptsclean"
	@-if test -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile); then \
	  $(MAKE) -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile) cmt_lock_pid=$${cmt_lock_pid} DatabaseSvc_check_install_scriptsclean; \
	fi

##	  /bin/rm -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile) $(bin)DatabaseSvc_check_install_scripts_dependencies.make

install :: DatabaseSvc_check_install_scriptsinstall

DatabaseSvc_check_install_scriptsinstall :: $(DatabaseSvc_check_install_scripts_dependencies) $(cmt_local_DatabaseSvc_check_install_scripts_makefile)
	$(echo) "(constituents.make) Starting install DatabaseSvc_check_install_scripts"
	@-$(MAKE) -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile) cmt_lock_pid=$${cmt_lock_pid} install
	$(echo) "(constituents.make) install DatabaseSvc_check_install_scripts done"

uninstall :: DatabaseSvc_check_install_scriptsuninstall

DatabaseSvc_check_install_scriptsuninstall :: $(cmt_local_DatabaseSvc_check_install_scripts_makefile)
	$(echo) "(constituents.make) Starting uninstall DatabaseSvc_check_install_scripts"
	@-$(MAKE) -f $(cmt_local_DatabaseSvc_check_install_scripts_makefile) cmt_lock_pid=$${cmt_lock_pid} uninstall
	$(echo) "(constituents.make) uninstall DatabaseSvc_check_install_scripts done"

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ DatabaseSvc_check_install_scripts"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ DatabaseSvc_check_install_scripts done"
endif


#-- end of constituent_lock ------

clean :: remove_library_links

remove_library_links ::
	@echo "Removing library links"; \
	  $(remove_library_links); \

makefilesclean ::
	@/bin/rm -f checkuses

#	/bin/rm -f *.make*

clean :: makefilesclean

binclean :: clean
	if test ! "$(bin)" = "./"; then /bin/rm -rf $(bin); fi

