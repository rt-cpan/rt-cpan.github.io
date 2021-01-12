#include <poppler.h>
#include <stdio.h>

int main(int argc, const char *argv[])
{
	if (argc < 2) {
		printf("Usage: %s <document>", argv[0]);
		return -1;
	}

	GError *err = NULL;
	PopplerDocument *doc = poppler_document_new_from_file(argv[1], NULL, &err);
	if (!doc) {
		fprintf(stderr, "Error creating poppler document: %s\n", err->message);
		g_error_free(err);
		return -2;
	}

	int npages = poppler_document_get_n_pages(doc);
	for (int i = 0; i < npages; i++) {
		PopplerPage *page = poppler_document_get_page(doc, i);
		if (!page) return -3;

		GList *mapping = poppler_page_get_annot_mapping(page);
		if (!mapping) {
			g_object_unref(page);
			continue;
		}

		for(GList *i=mapping; i; i = i->next) {
			PopplerAnnot* annot = ((PopplerAnnotMapping *)i->data)->annot;
			PopplerAnnotType type = poppler_annot_get_annot_type(annot);
			if (type == POPPLER_ANNOT_HIGHLIGHT) {
				GArray* quads = poppler_annot_text_markup_get_quadrilaterals((PopplerAnnotTextMarkup*) annot);
				for (guint i = 0; i < quads->len; i++) {
					PopplerQuadrilateral *quad = &g_array_index(quads, PopplerQuadrilateral, i);
					printf("%p\n", quad);
					// This free is invalid, as we will free quad twice, once here and once below
					g_free(quad);
				}
				// this is where the double free will then happen, because free_segment is set to 1, so we try to double free quad
				g_array_free(quads, 1);
			}
		}

		poppler_page_free_annot_mapping(mapping);

		g_object_unref(page);
	}

	g_object_unref(doc);

	return 0;
}
