/* gcc `pkg-config --libs --cflags gtk+-2.0` dialog.c -o dialog */

#include <gtk/gtk.h>

int
main (int argc, char **argv)
{
  GtkWidget *dialog;

  gtk_init (&argc, &argv);

  dialog = gtk_file_chooser_dialog_new ("Test",
					NULL,
					GTK_FILE_CHOOSER_ACTION_OPEN,
					GTK_STOCK_CANCEL, GTK_RESPONSE_CANCEL,
					GTK_STOCK_OPEN, GTK_RESPONSE_ACCEPT,
					NULL);

  gtk_widget_destroy (dialog);

  return 0;
}
