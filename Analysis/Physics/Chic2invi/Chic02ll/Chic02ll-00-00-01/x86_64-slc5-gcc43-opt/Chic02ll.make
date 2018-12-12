#-- start of make_header -----------------

#====================================
#  Library Chic02ll
#
#   Generated Thu Dec 13 00:32:38 2018  by amitraahul
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Chic02ll_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Chic02ll_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Chic02ll

Chic02ll_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_Chic02ll = /tmp/CMT_$(Chic02ll_tag)_Chic02ll.make$(cmt_lock_pid)
else
#cmt_local_tagfile_Chic02ll = $(Chic02ll_tag)_Chic02ll.make
cmt_local_tagfile_Chic02ll = $(bin)$(Chic02ll_tag)_Chic02ll.make
endif

else

tags      = $(tag),$(CMTEXTRATAGS)

Chic02ll_tag = $(tag)

ifdef READONLY
cmt_local_tagfile_Chic02ll = /tmp/CMT_$(Chic02ll_tag).make$(cmt_lock_pid)
else
#cmt_local_tagfile_Chic02ll = $(Chic02ll_tag).make
cmt_local_tagfile_Chic02ll = $(bin)$(Chic02ll_tag).make
endif

endif

-include $(cmt_local_tagfile_Chic02ll)

ifdef cmt_Chic02ll_has_target_tag

ifdef READONLY
cmt_final_setup_Chic02ll = /tmp/CMT_Chic02ll_Chic02llsetup.make
cmt_local_Chic02ll_makefile = /tmp/CMT_Chic02ll$(cmt_lock_pid).make
else
cmt_final_setup_Chic02ll = $(bin)Chic02ll_Chic02llsetup.make
cmt_local_Chic02ll_makefile = $(bin)Chic02ll.make
endif

else

ifdef READONLY
cmt_final_setup_Chic02ll = /tmp/CMT_Chic02llsetup.make
cmt_local_Chic02ll_makefile = /tmp/CMT_Chic02ll$(cmt_lock_pid).make
else
cmt_final_setup_Chic02ll = $(bin)Chic02llsetup.make
cmt_local_Chic02ll_makefile = $(bin)Chic02ll.make
endif

endif

ifdef READONLY
cmt_final_setup = /tmp/CMT_Chic02llsetup.make
else
cmt_final_setup = $(bin)Chic02llsetup.make
endif

Chic02ll ::


ifdef READONLY
Chic02ll ::
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
	$(echo) 'Chic02ll'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Chic02ll/
Chic02ll::
	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

#-- end of make_header ------------------

#-- start of libary_header ---------------

Chic02lllibname   = $(bin)$(library_prefix)Chic02ll$(library_suffix)
Chic02lllib       = $(Chic02lllibname).a
Chic02llstamp     = $(bin)Chic02ll.stamp
Chic02llshstamp   = $(bin)Chic02ll.shstamp

Chic02ll :: dirs  Chic02llLIB
	$(echo) "Chic02ll ok"

#-- end of libary_header ----------------

Chic02llLIB :: $(Chic02lllib) $(Chic02llshstamp)
	@/bin/echo "------> Chic02ll : library ok"

$(Chic02lllib) :: $(bin)Chic02ll.o $(bin)Chic02ll_entries.o $(bin)Chic02ll_load.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(Chic02lllib) $?
	$(lib_silent) $(ranlib) $(Chic02lllib)
	$(lib_silent) cat /dev/null >$(Chic02llstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

$(Chic02lllibname).$(shlibsuffix) :: $(Chic02lllib) $(Chic02llstamps)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" Chic02ll $(Chic02ll_shlibflags)

$(Chic02llshstamp) :: $(Chic02lllibname).$(shlibsuffix)
	@if test -f $(Chic02lllibname).$(shlibsuffix) ; then cat /dev/null >$(Chic02llshstamp) ; fi

Chic02llclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)Chic02ll.o $(bin)Chic02ll_entries.o $(bin)Chic02ll_load.o

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
Chic02llinstallname = $(library_prefix)Chic02ll$(library_suffix).$(shlibsuffix)

Chic02ll :: Chic02llinstall

install :: Chic02llinstall

Chic02llinstall :: $(install_dir)/$(Chic02llinstallname)
	@if test ! "${installarea}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(Chic02llinstallname) :: $(bin)$(Chic02llinstallname)
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test ! -d "$(install_dir)"; then \
	      mkdir -p $(install_dir); \
	    fi ; \
	    if test -d "$(install_dir)"; then \
	      echo "Installing library $(Chic02llinstallname) into $(install_dir)"; \
	      if test -e $(install_dir)/$(Chic02llinstallname); then \
	        $(cmt_uninstall_area_command) $(install_dir)/$(Chic02llinstallname); \
	        $(cmt_uninstall_area_command) $(install_dir)/$(Chic02llinstallname).cmtref; \
	      fi; \
	      $(cmt_install_area_command) `pwd`/$(Chic02llinstallname) $(install_dir)/$(Chic02llinstallname); \
	      echo `pwd`/$(Chic02llinstallname) >$(install_dir)/$(Chic02llinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot install library $(Chic02llinstallname), no installation directory specified"; \
	  fi; \
	fi

Chic02llclean :: Chic02lluninstall

uninstall :: Chic02lluninstall

Chic02lluninstall ::
	@if test ! "${installarea}" = ""; then \
	  cd $(bin); \
	  if test ! "$(install_dir)" = ""; then \
	    if test -d "$(install_dir)"; then \
	      echo "Removing installed library $(Chic02llinstallname) from $(install_dir)"; \
	      $(cmt_uninstall_area_command) $(install_dir)/$(Chic02llinstallname); \
	      $(cmt_uninstall_area_command) $(install_dir)/$(Chic02llinstallname).cmtref; \
	    fi \
          else \
	    echo "Cannot uninstall library $(Chic02llinstallname), no installation directory specified"; \
	  fi; \
	fi




#-- start of dependency ------------------
ifneq ($(MAKECMDGOALS),Chic02llclean)

#$(bin)Chic02ll_dependencies.make :: dirs

ifndef QUICK
$(bin)Chic02ll_dependencies.make : ../src/Chic02ll.cxx ../src/components/Chic02ll_entries.cxx ../src/components/Chic02ll_load.cxx $(use_requirements) $(cmt_final_setup_Chic02ll)
	$(echo) "(Chic02ll.make) Rebuilding $@"; \
	  $(build_dependencies) Chic02ll -all_sources -out=$@ ../src/Chic02ll.cxx ../src/components/Chic02ll_entries.cxx ../src/components/Chic02ll_load.cxx
endif

#$(Chic02ll_dependencies)

-include $(bin)Chic02ll_dependencies.make

endif
#-- end of dependency -------------------
#-- start of cpp_library -----------------

$(bin)Chic02ll_dependencies.make : $(Chic02ll_cxx_dependencies)

$(bin)$(binobj)Chic02ll.o : $(Chic02ll_cxx_dependencies)
	$(cpp_echo) $(src)Chic02ll.cxx
	$(cpp_silent) $(cppcomp) -o $(@) $(use_pp_cppflags) $(Chic02ll_pp_cppflags) $(lib_Chic02ll_pp_cppflags) $(Chic02ll_pp_cppflags) $(use_cppflags) $(Chic02ll_cppflags) $(lib_Chic02ll_cppflags) $(Chic02ll_cppflags) $(Chic02ll_cxx_cppflags)  $(src)Chic02ll.cxx

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

$(bin)Chic02ll_dependencies.make : $(Chic02ll_entries_cxx_dependencies)

$(bin)$(binobj)Chic02ll_entries.o : $(Chic02ll_entries_cxx_dependencies)
	$(cpp_echo) $(src)components/Chic02ll_entries.cxx
	$(cpp_silent) $(cppcomp) -o $(@) $(use_pp_cppflags) $(Chic02ll_pp_cppflags) $(lib_Chic02ll_pp_cppflags) $(Chic02ll_entries_pp_cppflags) $(use_cppflags) $(Chic02ll_cppflags) $(lib_Chic02ll_cppflags) $(Chic02ll_entries_cppflags) $(Chic02ll_entries_cxx_cppflags) -I../src/components $(src)components/Chic02ll_entries.cxx

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

$(bin)Chic02ll_dependencies.make : $(Chic02ll_load_cxx_dependencies)

$(bin)$(binobj)Chic02ll_load.o : $(Chic02ll_load_cxx_dependencies)
	$(cpp_echo) $(src)components/Chic02ll_load.cxx
	$(cpp_silent) $(cppcomp) -o $(@) $(use_pp_cppflags) $(Chic02ll_pp_cppflags) $(lib_Chic02ll_pp_cppflags) $(Chic02ll_load_pp_cppflags) $(use_cppflags) $(Chic02ll_cppflags) $(lib_Chic02ll_cppflags) $(Chic02ll_load_cppflags) $(Chic02ll_load_cxx_cppflags) -I../src/components $(src)components/Chic02ll_load.cxx

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: Chic02llclean
	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Chic02ll.make) $@: No rule for such target" >&2
#	@echo "#CMT> Warning: $@: No rule for such target" >&2; exit
else
.DEFAULT::
	$(echo) "(Chic02ll.make) PEDANTIC: $@: No rule for such target" >&2
	if test $@ = "$(cmt_final_setup)" -o\
	 $@ = "$(cmt_final_setup_Chic02ll)" ; then\
	 found=n; for s in 1 2 3 4 5; do\
	 sleep $$s; test ! -f $@ || { found=y; break; }\
	 done; if test $$found = n; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(Chic02ll.make) PEDANTIC: $@: Seems to be missing. Ignore it for now" >&2; exit 0 ; fi;\
	 elif test `expr index $@ '/'` -ne 0 ; then\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(Chic02ll.make) PEDANTIC: $@: Seems to be a missing file. Please check" >&2; exit 2 ; \
	 else\
	 test -z "$(cmtmsg)" ||\
	 echo "$(CMTMSGPREFIX)" "(Chic02ll.make) PEDANTIC: $@: Seems to be a fake target due to some pattern. Just ignore it" >&2 ; exit 0; fi
endif

Chic02llclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library
	-$(cleanup_silent) cd $(bin); /bin/rm -f $(binobj)$(library_prefix)Chic02ll$(library_suffix).a $(binobj)$(library_prefix)Chic02ll$(library_suffix).s? $(binobj)Chic02ll.stamp $(binobj)Chic02ll.shstamp
#-- end of cleanup_library ---------------

