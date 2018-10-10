#-- start of make_header -----------------

#====================================
#  Library Chic02ee
#
#   Generated Wed Oct 10 16:24:54 2018  by amitraahul
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Chic02ee_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Chic02ee_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Chic02ee

Chic02ee_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_Chic02ee = /tmp/CMT_$(Chic02ee_tag)_Chic02ee.make$(cmt_lock_pid)
else
#cmt_local_tagfile_Chic02ee = $(Chic02ee_tag)_Chic02ee.make
cmt_local_tagfile_Chic02ee = $(bin)$(Chic02ee_tag)_Chic02ee.make
endif

else

tags      = $(tag),$(CMTEXTRATAGS)

Chic02ee_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_Chic02ee = /tmp/CMT_$(Chic02ee_tag).make$(cmt_lock_pid)
else
#cmt_local_tagfile_Chic02ee = $(Chic02ee_tag).make
cmt_local_tagfile_Chic02ee = $(bin)$(Chic02ee_tag).make
endif

endif

-include $(cmt_local_tagfile_Chic02ee)

ifdef cmt_Chic02ee_has_target_tag

ifdef READONLY
cmt_final_setup_Chic02ee = /tmp/CMT_Chic02ee_Chic02eesetup.make
cmt_local_Chic02ee_makefile = /tmp/CMT_Chic02ee$(cmt_lock_pid).make
else
cmt_final_setup_Chic02ee = $(bin)Chic02ee_Chic02eesetup.make
cmt_local_Chic02ee_makefile = $(bin)Chic02ee.make
endif

else

ifdef READONLY
cmt_final_setup_Chic02ee = /tmp/CMT_Chic02eesetup.make
cmt_local_Chic02ee_makefile = /tmp/CMT_Chic02ee$(cmt_lock_pid).make
else
cmt_final_setup_Chic02ee = $(bin)Chic02eesetup.make
cmt_local_Chic02ee_makefile = $(bin)Chic02ee.make
endif

endif

ifdef READONLY
cmt_final_setup = /tmp/CMT_Chic02eesetup.make
else
cmt_final_setup = $(bin)Chic02eesetup.make
endif

Chic02ee ::


ifdef READONLY
Chic02ee ::
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
	$(echo) 'Chic02ee'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Chic02ee/
Chic02ee::
	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

#-- end of make_header ------------------

#-- start of libary_header ---------------

Chic02eelibname   = $(bin)$(library_prefix)Chic02ee$(library_suffix)
Chic02eelib       = $(Chic02eelibname).a
Chic02eestamp     = $(bin)Chic02ee.stamp
Chic02eeshstamp   = $(bin)Chic02ee.shstamp

Chic02ee :: dirs  Chic02eeLIB
	$(echo) "Chic02ee ok"

#-- end of libary_header ----------------

Chic02eeLIB :: $(Chic02eelib) $(Chic02eeshstamp)
	@/bin/echo "------> Chic02ee : library ok"

$(Chic02eelib) :: $(bin)Chic02ee.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(Chic02eelib) $?
	$(lib_silent) $(ranlib) $(Chic02eelib)
	$(lib_silent) cat /dev/null >$(Chic02eestamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(Chic02eelibname).$(shlibsuffix) :: $(Chic02eelib) $(Chic02eestamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" Chic02ee $(Chic02ee_shlibflags)

$(Chic02eeshstamp) :: $(Chic02eelibname).$(shlibsuffix)
	@if test -f $(Chic02eelibname).$(shlibsuffix) ; then cat /dev/null >$(Chic02eeshstamp) ; fi

Chic02eeclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)Chic02ee.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

ifeq ($(INSTALLAREA),)
installarea = $(CMTINSTALLAREA)
else
ifeq ($(findstring `,$(INSTALLAREA)),`)
installarea = $(shell $(subst `,, $(INSTALLAREA)))
else
installarea = $(INSTALLAREA)
endif
endif

install_dir = ${installarea}/${CMTCONFIG}/lib
Chic02eeinstallname = $(library_prefix)Chic02ee$(library_suffix).$(shlibsuffix)

Chic02ee :: Chic02eeinstall

install :: Chic02eeinstall

Chic02eeinstall :: $(install_dir)/$(Chic02eeinstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(Chic02eeinstallname) :: $(bin)$(Chic02eeinstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(Chic02eeinstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(Chic02eeinstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(Chic02eeinstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(Chic02eeinstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(Chic02eeinstallname) $(install_dir)/$(Chic02eeinstallname); \
	      echo `pwd`/$(Chic02eeinstallname) >$(install_dir)/$(Chic02eeinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(Chic02eeinstallname), no installation directory specified"; \
	  fi; \
	fi

Chic02eeclean :: Chic02eeuninstall

uninstall :: Chic02eeuninstall

Chic02eeuninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(Chic02eeinstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(Chic02eeinstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(Chic02eeinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(Chic02eeinstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of dependency ------------------
ifneq ($(MAKECMDGOALS),Chic02eeclean)

#$(bin)Chic02ee_dependencies.make :: dirs

ifndef QUICK
$(bin)Chic02ee_dependencies.make : ../src/Chic02ee.cc $(use_requirements) $(cmt_final_setup_Chic02ee)
	$(echo) "(Chic02ee.make) Rebuilding $@"; \
	  $(build_dependencies) Chic02ee -all_sources -out=$@ ../src/Chic02ee.cc
endif

#$(Chic02ee_dependencies)

-include $(bin)Chic02ee_dependencies.make

endif
#-- end of dependency -------------------
#-- start of cpp_library -----------------

$(bin)Chic02ee_dependencies.make : $(Chic02ee_cc_dependencies)

$(bin)$(binobj)Chic02ee.o : $(Chic02ee_cc_dependencies)
	$(cpp_echo) $(src)Chic02ee.cc
	$(cpp_silent) $(cppcomp) -o $(@) $(use_pp_cppflags) $(Chic02ee_pp_cppflags) $(lib_Chic02ee_pp_cppflags) $(Chic02ee_pp_cppflags) $(use_cppflags) $(Chic02ee_cppflags) $(lib_Chic02ee_cppflags) $(Chic02ee_cppflags) $(Chic02ee_cc_cppflags)  $(src)Chic02ee.cc

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: Chic02eeclean
	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Chic02ee.make) $@: No rule for such target" >&2
#	@echo "#CMT> Warning: $@: No rule for such target" >&2; exit
else
.DEFAULT::
	$(echo) "(Chic02ee.make) PEDANTIC: $@: No rule for such target" >&2
	if test $@ = "$(cmt_final_setup)" -o\
	 $@ = "$(cmt_final_setup_Chic02ee)" ; then\
	 found=n; for s in 1 2 3 4 5; do\
	 sleep $$s; test ! -f $@ || { found=y; break; }\
	 done; if test $$found = n; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(Chic02ee.make) PEDANTIC: $@: Seems to be missing. Ignore it for now" >&2; exit 0 ; fi;\
	 elif test `expr index $@ '/'` -ne 0 ; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(Chic02ee.make) PEDANTIC: $@: Seems to be a missing file. Please check" >&2; exit 2 ; \
	 else\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(Chic02ee.make) PEDANTIC: $@: Seems to be a fake target due to some pattern. Just ignore it" >&2 ; exit 0; fi
endif

Chic02eeclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(binobj)$(library_prefix)Chic02ee$(library_suffix).a $(binobj)$(library_prefix)Chic02ee$(library_suffix).s? $(binobj)Chic02ee.stamp $(binobj)Chic02ee.shstamp
#-- end of cleanup_library ---------------

