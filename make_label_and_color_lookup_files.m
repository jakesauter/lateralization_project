[vertices,label,colortable]=read_annotation('label/lh.aparc.annot');

colortable.table(:,5) = colortable.table(:,1) + (colortable.table(:,2) * (2^8)) + (colortable.table(:,3)*(2^16)) + (colortable.table(:,4)*(2^24));

write_annotation('lh.test.annot', vertices,label,colortable);