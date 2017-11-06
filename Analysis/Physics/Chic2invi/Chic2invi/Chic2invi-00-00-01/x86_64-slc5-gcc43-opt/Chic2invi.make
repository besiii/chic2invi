#-- start of make_header -----------------

#====================================
#  Library Chic2invi
#
#   Generated Fri Nov  3 15:00:52 2017  by xiaosy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Chic2invi_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Chic2invi_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Chic2invi

Chic2invi_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_Chic2invi = /tmp/CMT_$(Chic2invi_tag)_Chic2invi.make$(cmt_lock_pid)
else
#cmt_local_tagfile_Chic2invi = $(Chic2invi_tag)_Chic2invi.make
cmt_local_tagfile_Chic2invi = $(bin)$(Chic2invi_tag)_Chic2invi.make
endif

else

tags      = $(tag),$(CMTEXTRATAGS)

Chic2invi_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_Chic2invi = /tmp/CMT_$(Chic2invi_tag).make$(cmt_lock_pid)
else
#cmt_local_tagfile_Chic2invi = $(Chic2invi_tag).make
cmt_local_tagfile_Chic2invi = $(bin)$(Chic2invi_tag).make
endif

endif

-include $(cmt_local_tagfile_Chic2invi)

ifdef cmt_Chic2invi_has_target_tag

ifdef READONLY
cmt_final_setup_Chic2invi = /tmp/CMT_Chic2invi_Chic2invisetup.make
cmt_local_Chic2invi_makefile = /tmp/CMT_Chic2invi$(cmt_lock_pid).make
else
cmt_final_setup_Chic2invi = $(bin)Chic2invi_Chic2invisetup.make
cmt_local_Chic2invi_makefile = $(bin)Chic2invi.make
endif

else

ifdef READONLY
cmt_final_setup_Chic2invi = /tmp/CMT_Chic2invisetup.make
cmt_local_Chic2invi_makefile = /tmp/CMT_Chic2invi$(cmt_lock_pid).make
else
cmt_final_setup_Chic2invi = $(bin)Chic2invisetup.make
cmt_local_Chic2invi_makefile = $(bin)Chic2invi.make
endif

endif

ifdef READONLY
cmt_final_setup = /tmp/CMT_Chic2invisetup.make
else
cmt_final_setup = $(bin)Chic2invisetup.make
endif

Chic2invi ::


ifdef READONLY
Chic2invi ::
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
	$(echo) 'Chic2invi'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Chic2invi/
Chic2invi::
	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

#-- end of make_header ------------------

#-- start of libary_header ---------------

Chic2invilibname   = $(bin)$(library_prefix)Chic2invi$(library_suffix)
Chic2invilib       = $(Chic2invilibname).a
Chic2invistamp     = $(bin)Chic2invi.stamp
Chic2invishstamp   = $(bin)Chic2invi.shstamp

Chic2invi :: dirs  Chic2inviLIB
	$(echo) "Chic2invi ok"

#-- end of libary_header ----------------

Chic2inviLIB :: $(Chic2invilib) $(Chic2invishstamp)
	@/bin/echo "------> Chic2invi : library ok"

$(Chic2invilib) :: $(bin)Chic2invi.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(Chic2invilib) $?
	$(lib_silent) $(ranlib) $(Chic2invilib)
	$(lib_silent) cat /dev/null >$(Chic2invistamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(Chic2invilibname).$(shlibsuffix) :: $(Chic2invilib) $(Chic2invistamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" Chic2invi $(Chic2invi_shlibflags)

$(Chic2invishstamp) :: $(Chic2invilibname).$(shlibsuffix)
	@if test -f $(Chic2invilibname).$(shlibsuffix) ; then cat /dev/null >$(Chic2invishstamp) ; fi

Chic2inviclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)Chic2invi.o

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
Chic2inviinstallname = $(library_prefix)Chic2invi$(library_suffix).$(shlibsuffix)

Chic2invi :: Chic2inviinstall

install :: Chic2inviinstall

Chic2inviinstall :: $(install_dir)/$(Chic2inviinstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(Chic2inviinstallname) :: $(bin)$(Chic2inviinstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(Chic2inviinstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(Chic2inviinstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(Chic2inviinstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(Chic2inviinstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(Chic2inviinstallname) $(install_dir)/$(Chic2inviinstallname); \
	      echo `pwd`/$(Chic2inviinstallname) >$(install_dir)/$(Chic2inviinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(Chic2inviinstallname), no installation directory specified"; \
	  fi; \
	fi

Chic2inviclean :: Chic2inviuninstall

uninstall :: Chic2inviuninstall

Chic2inviuninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(Chic2inviinstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(Chic2inviinstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(Chic2inviinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(Chic2inviinstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of dependency ------------------
ifneq ($(MAKECMDGOALS),Chic2inviclean)

#$(bin)Chic2invi_dependencies.make :: dirs

ifndef QUICK
$(bin)Chic2invi_dependencies.make : ../src/Chic2invi.cc $(use_requirements) $(cmt_final_setup_Chic2invi)
	$(echo) "(Chic2invi.make) Rebuilding $@"; \
	  $(build_dependencies) Chic2invi -all_sources -out=$@ ../src/Chic2invi.cc
endif

#$(Chic2invi_dependencies)

-include $(bin)Chic2invi_dependencies.make

endif
#-- end of dependency -------------------
#-- start of cpp_library -----------------

$(bin)Chic2invi_dependencies.make : $(Chic2invi_cc_dependencies)

$(bin)$(binobj)Chic2invi.o : $(Chic2invi_cc_dependencies)
	$(cpp_echo) $(src)Chic2invi.cc
	$(cpp_silent) $(cppcomp) -o $(@) $(use_pp_cppflags) $(Chic2invi_pp_cppflags) $(lib_Chic2invi_pp_cppflags) $(Chic2invi_pp_cppflags) $(use_cppflags) $(Chic2invi_cppflags) $(lib_Chic2invi_cppflags) $(Chic2invi_cppflags) $(Chic2invi_cc_cppflags)  $(src)Chic2invi.cc

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: Chic2inviclean
	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Chic2invi.make) $@: No rule for such target" >&2
#	@echo "#CMT> Warning: $@: No rule for such target" >&2; exit
else
.DEFAULT::
	$(echo) "(Chic2invi.make) PEDANTIC: $@: No rule for such target" >&2
	if test $@ = "$(cmt_final_setup)" -o\
	 $@ = "$(cmt_final_setup_Chic2invi)" ; then\
	 found=n; for s in 1 2 3 4 5; do\
	 sleep $$s; test ! -f $@ || { found=y; break; }\
	 done; if test $$found = n; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(Chic2invi.make) PEDANTIC: $@: Seems to be missing. Ignore it for now" >&2; exit 0 ; fi;\
	 elif test `expr index $@ '/'` -ne 0 ; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(Chic2invi.make) PEDANTIC: $@: Seems to be a missing file. Please check" >&2; exit 2 ; \
	 else\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(Chic2invi.make) PEDANTIC: $@: Seems to be a fake target due to some pattern. Just ignore it" >&2 ; exit 0; fi
endif

Chic2inviclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(binobj)$(library_prefix)Chic2invi$(library_suffix).a $(binobj)$(library_prefix)Chic2invi$(library_suffix).s? $(binobj)Chic2invi.stamp $(binobj)Chic2invi.shstamp
#-- end of cleanup_library ---------------

