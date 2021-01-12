#include <gnome.h>

/* our main function */
int main(int argc, char *argv[])
{
	GnomeApp *app; /* the main window pointer */
	GnomeCanvas *canvas; /* the canvas */
	GtkWidget *w;

	gnome_init("test", "1", argc, argv);
	app = GNOME_APP(gnome_app_new("test", "Test"));
	
	/* create a new canvas */
	w = gnome_canvas_new();
	canvas = GNOME_CANVAS(w);

	gnome_canvas_item_new(gnome_canvas_root(canvas),
			      gnome_canvas_rect_get_type(),
			      "x1", 90.0,
			      "y1", 40.0,
			      "x2", 33000.0, 
			      "y2", 100.0,
			      "fill_color", "mediumseagreen",
			      "outline_color", "black",
			      "width_units", 4.0,
			      NULL);

	/* set where can the canvas scroll (our usable area) */
	gnome_canvas_set_scroll_region(canvas, 0.0, 0.0, 60000.0, 6000.0);

	/* set the contents of the app window to the canvas */
	gnome_app_set_contents(GNOME_APP(app), w);
	gtk_widget_show_all(GTK_WIDGET(app));
	gtk_main();
	return 0;
}
