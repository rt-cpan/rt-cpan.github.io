pp -o gen_kml_track.exe gen_kml_track.pl ^
-I "..\perl libraries" ^
-M feature ^
-M attributes ^
-M "MooseX::Aliases::Meta::Trait::Attribute" ^
-M "MooseX::Aliases::Meta::Trait::Constructor" ^
-M "MooseX::Aliases::Meta::Trait::Method" ^
-M "Cairo" ^
-M "Text::CSV_XS" ^
-M "Text::CSV_PP" ^
--lib c:/strawberry/perl/vendor/lib ^
-a AirservicesLogo.png ^
-l c:\strawberry\perl\site\lib\auto\Cairo\Cairo.dll ^
-l c:\strawberry\perl\site\lib\auto\Glib\Glib.dll ^
-l c:\strawberry\perl\site\lib\auto\Pango\Pango.dll ^
-l c:\strawberry\perl\site\lib\auto\Gtk2\Gtk2.dll ^
-l c:\gtk\bin\libatk-1.0-0.dll ^
-l c:\gtk\bin\libcairo-2.dll ^
-l c:\gtk\bin\libexpat-1.dll ^
-l c:\gtk\bin\libfontconfig-1.dll ^
-l c:\gtk\bin\libgailutil-18.dll ^
-l c:\gtk\bin\libgdk_pixbuf-2.0-0.dll ^
-l c:\gtk\bin\libgdk-win32-2.0-0.dll ^
-l c:\gtk\bin\libgio-2.0-0.dll ^
-l c:\gtk\bin\libglib-2.0-0.dll ^
-l c:\gtk\bin\libgmodule-2.0-0.dll ^
-l c:\gtk\bin\libgobject-2.0-0.dll ^
-l c:\gtk\bin\libgthread-2.0-0.dll ^
-l c:\gtk\bin\libgtk-win32-2.0-0.dll ^
-l c:\gtk\bin\libpango-1.0-0.dll ^
-l c:\gtk\bin\libpangocairo-1.0-0.dll ^
-l c:\gtk\bin\libpangoft2-1.0-0.dll ^
-l c:\gtk\bin\libpangowin32-1.0-0.dll ^
-l c:\gtk\bin\libpng14-14.dll ^
-l c:\gtk\bin\freetype6.dll ^
-l c:\gtk\bin\zlib1.dll ^
-l "c:\Program Files\ImageMagick-6.6.3-Q16\convert.exe" ^
-l "c:\Program Files\ImageMagick-6.6.3-Q16\identify.exe" ^
-l "c:\Program Files\ImageMagick-6.6.3-Q16\CORE_RL_wand_.dll" ^
-l "c:\Program Files\ImageMagick-6.6.3-Q16\X11.dll" ^
-vvv

:: --gui ^


:: I need to be running Module::ScanDeps 0.73 for GTK to work
:: -M feature Required by use 5.010, new ScanDeps fixes this
:: -l dlls due to unknown PAR::Packer bug
:: The wrong slashes in --lib are REQUIRED
:: Doesn't seem to find Moose Roles, may be fixed in new ScanDeps
:: When debugging pull the --gui line out, it hides STDERR.
