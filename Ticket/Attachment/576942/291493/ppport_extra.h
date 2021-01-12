
#ifndef SvRXOK
#define SvRXOK(sv) my_SvRXOK(aTHX_ sv)
/* see also Perl_get_re_arg() in util.c (5.10.0) */
STATIC bool
my_SvRXOK(pTHX_ SV* sv){
	SvGETMAGIC(sv);

	if(SvROK(sv)){
		sv = SvRV(sv);
		if(SvMAGICAL(sv) && mg_find(sv, PERL_MAGIC_qr)){
			return TRUE;
		}
	}
	return FALSE;
}
#endif

#ifndef newSV_type
#define newSV_type(t) my_newSV_type(aTHX_ t)
STATIC SV*
my_newSV_type(pTHX_ svtype const t){
	SV* const sv = newSV(0);
	sv_upgrade(sv, t);
	return sv;
}
#endif

#ifndef gv_fetchpvs
#define gv_fetchpvs(name, flags, svt) gv_fetchpv((name ""), flags, svt)
#endif

#ifndef gv_stashpvs
#define gv_stashpvs(name, flags) Perl_gv_stashpvn(aTHX_ STR_WITH_LEN(name), flags)
#endif

#ifndef GvSVn
#define GvSVn(sv) GvSV(sv)
#endif

#ifndef HvNAME_get
#define HvNAME_get(hv) HvNAME(hv)
#endif

#ifndef HvNAMELEN_get
#define HvNAMELEN_get(hv) (strlen(HvNAME_get(hv)))
#endif

#ifndef SvIS_FREED
#define SvIS_FREED(sv) (SvFLAGS(sv) == SVTYPEMASK)
#endif
