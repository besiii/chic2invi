#-- start of make_header -----------------

#====================================
#  Document Chic02ll_check_install_runtime
#
#   Generated Thu Dec 13 00:33:07 2018  by amitraahul
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Chic02ll_check_install_runtime_has_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Chic02ll_check_install_runtime_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Chic02ll_check_install_runtime

Chic02ll_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_Chic02ll_check_install_runtime = /tmp/CMT_$(Chic02ll_tag)_Chic02ll_check_install_runtime.make$(cmt_lock_pid)
else
#cmt_local_tagfile_Chic02ll_check_install_runtime = $(Chic02ll_tag)_Chic02ll_check_install_runtime.make
cmt_local_tagfile_Chic02ll_check_install_runtime = $(bin)$(Chic02ll_tag)_Chic02ll_check_install_runtime.make
endif

else

tags      = $(tag),$(CMTEXTRATAGS)

Chic02ll_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_Chic02ll_check_install_runtime = /tmp/CMT_$(Chic02ll_tag).make$(cmt_lock_pid)
else
#cmt_local_tagfile_Chic02ll_check_install_runtime = $(Chic02ll_tag).make
cmt_local_tagfile_Chic02ll_check_install_runtime = $(bin)$(Chic02ll_tag).make
endif

endif

-include $(cmt_local_tagfile_Chic02ll_check_install_runtime)

ifdef cmt_Chic02ll_check_install_runtime_has_target_tag

ifdef READONLY
cmt_final_setup_Chic02ll_check_install_runtime = /tmp/CMT_Chic02ll_Chic02ll_check_install_runtimesetup.make
cmt_local_Chic02ll_check_install_runtime_makefile = /tmp/CMT_Chic02ll_check_install_runtime$(cmt_lock_pid).make
else
cmt_final_setup_Chic02ll_check_install_runtime = $(bin)Chic02ll_Chic02ll_check_install_runtimesetup.make
cmt_local_Chic02ll_check_install_runtime_makefile = $(bin)Chic02ll_check_install_runtime.make
endif

else

ifdef READONLY
cmt_final_setup_Chic02ll_check_install_runtime = /tmp/CMT_Chic02llsetup.make
cmt_local_Chic02ll_check_install_runtime_makefile = /tmp/CMT_Chic02ll_check_install_runtime$(cmt_lock_pid).make
else
cmt_final_setup_Chic02ll_check_install_runtime = $(bin)Chic02llsetup.make
cmt_local_Chic02ll_check_install_runtime_makefile = $(bin)Chic02ll_check_install_runtime.make
endif

endif

ifdef READONLY
cmt_final_setup = /tmp/CMT_Chic02llsetup.make
else
cmt_final_setup = $(bin)Chic02llsetup.make
endif

Chic02ll_check_install_runtime ::


ifdef READONLY
Chic02ll_check_install_runtime ::
	@echo tags=$(tags)
	@echo cmt_local_tagfile=$(cmt_local_tagfile)
endif


dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'Chic02ll_check_install_runtime'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Chic02ll_check_install_runtime/
Chic02ll_check_install_runtime::
	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

#-- end of make_header ------------------

#-- start of cmt_action_runner_header ---------------

ifdef ONCE
Chic02ll_check_install_runtime_once = 1
endif

ifdef Chic02ll_check_install_runtime_once

Chic02ll_check_install_runtimeactionstamp = Chic02ll_check_install_runtime.actionstamp

Chic02ll_check_install_runtime :: $(Chic02ll_check_install_runtimeactionstamp)
	@echo Chic02ll_check_install_runtime ok

$(Chic02ll_check_install_runtimeactionstamp) :: $(Chic02ll_check_install_runtime_dependencies)
	$(silent) /afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/BesPolicy/BesPolicy-01-05-03/cmt/bes_check_installations.sh -files= -s=../share *.txt   -installdir=/afs/ihep.ac.cn/users/a/amitraahul/bes/chic2invi/v0.1/InstallArea/share
	@echo ok > $(Chic02ll_check_install_runtimeactionstamp)

Chic02ll_check_install_runtimeclean ::
	@/bin/rm -f $(Chic02ll_check_install_runtimeactionstamp)

else

Chic02ll_check_install_runtime :: $(Chic02ll_check_install_runtime_dependencies)
	$(silent) /afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/BesPolicy/BesPolicy-01-05-03/cmt/bes_check_installations.sh -files= -s=../share *.txt   -installdir=/afs/ihep.ac.cn/users/a/amitraahul/bes/chic2invi/v0.1/InstallArea/share

endif

install ::
uninstall ::

#-- end of cmt_action_runner_header -----------------
#-- start of cleanup_header --------------

clean :: Chic02ll_check_install_runtimeclean
	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Chic02ll_check_install_runtime.make) $@: No rule for such target" >&2
#	@echo "#CMT> Warning: $@: No rule for such target" >&2; exit
else
.DEFAULT::
	$(echo) "(Chic02ll_check_install_runtime.make) PEDANTIC: $@: No rule for such target" >&2
	if test $@ = "$(cmt_final_setup)" -o\
	 $@ = "$(cmt_final_setup_Chic02ll_check_install_runtime)" ; then\
	 found=n; for s in 1 2 3 4 5; do\
	 sleep $$s; test ! -f $@ || { found=y; break; }\
	 done; if test $$found = n; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(Chic02ll_check_install_runtime.make) PEDANTIC: $@: Seems to be missing. Ignore it for now" >&2; exit 0 ; fi;\
	 elif test `expr index $@ '/'` -ne 0 ; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(Chic02ll_check_install_runtime.make) PEDANTIC: $@: Seems to be a missing file. Please check" >&2; exit 2 ; \
	 else\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(Chic02ll_check_install_runtime.make) PEDANTIC: $@: Seems to be a fake target due to some pattern. Just ignore it" >&2 ; exit 0; fi
endif

Chic02ll_check_install_runtimeclean ::
#-- end of cleanup_header ---------------
