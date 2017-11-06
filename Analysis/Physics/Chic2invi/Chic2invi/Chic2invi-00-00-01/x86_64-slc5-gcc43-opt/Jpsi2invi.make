#-- start of make_header -----------------

#====================================
#  Library Jpsi2invi
#
#   Generated Wed Nov  1 18:47:58 2017  by xiaosy
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Jpsi2invi_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Jpsi2invi_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Jpsi2invi

chic2invi_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_Jpsi2invi = /tmp/CMT_$(chic2invi_tag)_Jpsi2invi.make$(cmt_lock_pid)
else
#cmt_local_tagfile_Jpsi2invi = $(chic2invi_tag)_Jpsi2invi.make
cmt_local_tagfile_Jpsi2invi = $(bin)$(chic2invi_tag)_Jpsi2invi.make
endif

else

tags      = $(tag),$(CMTEXTRATAGS)

chic2invi_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_Jpsi2invi = /tmp/CMT_$(chic2invi_tag).make$(cmt_lock_pid)
else
#cmt_local_tagfile_Jpsi2invi = $(chic2invi_tag).make
cmt_local_tagfile_Jpsi2invi = $(bin)$(chic2invi_tag).make
endif

endif

-include $(cmt_local_tagfile_Jpsi2invi)

ifdef cmt_Jpsi2invi_has_target_tag

ifdef READONLY
cmt_final_setup_Jpsi2invi = /tmp/CMT_chic2invi_Jpsi2invisetup.make
cmt_local_Jpsi2invi_makefile = /tmp/CMT_Jpsi2invi$(cmt_lock_pid).make
else
cmt_final_setup_Jpsi2invi = $(bin)chic2invi_Jpsi2invisetup.make
cmt_local_Jpsi2invi_makefile = $(bin)Jpsi2invi.make
endif

else

ifdef READONLY
cmt_final_setup_Jpsi2invi = /tmp/CMT_chic2invisetup.make
cmt_local_Jpsi2invi_makefile = /tmp/CMT_Jpsi2invi$(cmt_lock_pid).make
else
cmt_final_setup_Jpsi2invi = $(bin)chic2invisetup.make
cmt_local_Jpsi2invi_makefile = $(bin)Jpsi2invi.make
endif

endif

ifdef READONLY
cmt_final_setup = /tmp/CMT_chic2invisetup.make
else
cmt_final_setup = $(bin)chic2invisetup.make
endif

Jpsi2invi ::


ifdef READONLY
Jpsi2invi ::
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
	$(echo) 'Jpsi2invi'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Jpsi2invi/
Jpsi2invi::
	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

#-- end of make_header ------------------

#-- start of libary_header ---------------

Jpsi2invilibname   = $(bin)$(library_prefix)Jpsi2invi$(library_suffix)
Jpsi2invilib       = $(Jpsi2invilibname).a
Jpsi2invistamp     = $(bin)Jpsi2invi.stamp
Jpsi2invishstamp   = $(bin)Jpsi2invi.shstamp

Jpsi2invi :: dirs  Jpsi2inviLIB
	$(echo) "Jpsi2invi ok"

#-- end of libary_header ----------------

Jpsi2inviLIB :: $(Jpsi2invilib) $(Jpsi2invishstamp)
	@/bin/echo "------> Jpsi2invi : library ok"

$(Jpsi2invilib) :: $(bin)Chic2invi.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(Jpsi2invilib) $?
	$(lib_silent) $(ranlib) $(Jpsi2invilib)
	$(lib_silent) cat /dev/null >$(Jpsi2invistamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(Jpsi2invilibname).$(shlibsuffix) :: $(Jpsi2invilib) $(Jpsi2invistamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" Jpsi2invi $(Jpsi2invi_shlibflags)

$(Jpsi2invishstamp) :: $(Jpsi2invilibname).$(shlibsuffix)
	@if test -f $(Jpsi2invilibname).$(shlibsuffix) ; then cat /dev/null >$(Jpsi2invishstamp) ; fi

Jpsi2inviclean ::
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
Jpsi2inviinstallname = $(library_prefix)Jpsi2invi$(library_suffix).$(shlibsuffix)

Jpsi2invi :: Jpsi2inviinstall

install :: Jpsi2inviinstall

Jpsi2inviinstall :: $(install_dir)/$(Jpsi2inviinstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(Jpsi2inviinstallname) :: $(bin)$(Jpsi2inviinstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(Jpsi2inviinstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(Jpsi2inviinstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(Jpsi2inviinstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(Jpsi2inviinstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(Jpsi2inviinstallname) $(install_dir)/$(Jpsi2inviinstallname); \
	      echo `pwd`/$(Jpsi2inviinstallname) >$(install_dir)/$(Jpsi2inviinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(Jpsi2inviinstallname), no installation directory specified"; \
	  fi; \
	fi

Jpsi2inviclean :: Jpsi2inviuninstall

uninstall :: Jpsi2inviuninstall

Jpsi2inviuninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(Jpsi2inviinstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(Jpsi2inviinstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(Jpsi2inviinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(Jpsi2inviinstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of dependency ------------------
ifneq ($(MAKECMDGOALS),Jpsi2inviclean)

#$(bin)Jpsi2invi_dependencies.make :: dirs

ifndef QUICK
$(bin)Jpsi2invi_dependencies.make : ../src/Chic2invi.cc $(use_requirements) $(cmt_final_setup_Jpsi2invi)
	$(echo) "(Jpsi2invi.make) Rebuilding $@"; \
	  $(build_dependencies) Jpsi2invi -all_sources -out=$@ ../src/Chic2invi.cc
endif

#$(Jpsi2invi_dependencies)

-include $(bin)Jpsi2invi_dependencies.make

endif
#-- end of dependency -------------------
#-- start of cpp_library -----------------

$(bin)Jpsi2invi_dependencies.make : $(Chic2invi_cc_dependencies)

$(bin)$(binobj)Chic2invi.o : $(Chic2invi_cc_dependencies)
	$(cpp_echo) $(src)Chic2invi.cc
	$(cpp_silent) $(cppcomp) -o $(@) $(use_pp_cppflags) $(Jpsi2invi_pp_cppflags) $(lib_Jpsi2invi_pp_cppflags) $(Chic2invi_pp_cppflags) $(use_cppflags) $(Jpsi2invi_cppflags) $(lib_Jpsi2invi_cppflags) $(Chic2invi_cppflags) $(Chic2invi_cc_cppflags)  $(src)Chic2invi.cc

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: Jpsi2inviclean
	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Jpsi2invi.make) $@: No rule for such target" >&2
#	@echo "#CMT> Warning: $@: No rule for such target" >&2; exit
else
.DEFAULT::
	$(echo) "(Jpsi2invi.make) PEDANTIC: $@: No rule for such target" >&2
	if test $@ = "$(cmt_final_setup)" -o\
	 $@ = "$(cmt_final_setup_Jpsi2invi)" ; then\
	 found=n; for s in 1 2 3 4 5; do\
	 sleep $$s; test ! -f $@ || { found=y; break; }\
	 done; if test $$found = n; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(Jpsi2invi.make) PEDANTIC: $@: Seems to be missing. Ignore it for now" >&2; exit 0 ; fi;\
	 elif test `expr index $@ '/'` -ne 0 ; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(Jpsi2invi.make) PEDANTIC: $@: Seems to be a missing file. Please check" >&2; exit 2 ; \
	 else\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(Jpsi2invi.make) PEDANTIC: $@: Seems to be a fake target due to some pattern. Just ignore it" >&2 ; exit 0; fi
endif

Jpsi2inviclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(binobj)$(library_prefix)Jpsi2invi$(library_suffix).a $(binobj)$(library_prefix)Jpsi2invi$(library_suffix).s? $(binobj)Jpsi2invi.stamp $(binobj)Jpsi2invi.shstamp
#-- end of cleanup_library ---------------

