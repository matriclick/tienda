class CreateWeddingPlannerQuotes < ActiveRecord::Migration
  def change
    create_table :wedding_planner_quotes do |t|
      t.string :nombre_novia
      t.string :fono_novia
      t.string :nombre_novio
      t.string :fono_novio
      t.date :fecha_del_matrimonio
      t.string :cantidad_de_invitados
      t.string :presupuesto_banqueteria
      t.string :presupuesto_centro_de_eventos
      t.string :presupuesto_iglesia
      t.string :presupuesto_civil
      t.string :presupuesto_coro
      t.string :presupuesto_flores
      t.string :presupuesto_arriendo_auto
      t.string :presupuesto_decoracion_salon
      t.string :presupuesto_musica_iluminacion
      t.string :presupuesto_argollas
      t.string :presupuesto_fotografia
      t.string :presupuesto_video
      t.string :presupuesto_animacion
      t.string :presupuesto_cotillon
      t.string :presupuesto_partes_de_matrimonio
      t.string :presupuesto_torta_de_novios
      t.string :presupuesto_recuerdo_matrimonio
      t.string :presupuesto_vinos
      t.string :presupuesto_bar_destilados
      t.string :presupuesto_vestido_novia
      t.string :presupuesto_maquillaje
      t.string :presupuesto_peinado
      t.string :presupuesto_tocado
      t.string :presupuesto_ramo_de_novia
      t.string :presupuesto_zapatos
      t.string :presupuesto_traje_novio
      t.string :presupuesto_camisa_a_medida
      t.string :presupuesto_zapatos
      t.string :presupuesto_extras
      t.text :comentarios_adicionales

      t.timestamps
    end
  end
end
