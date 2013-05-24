class AddPresupuestoZapatosNovioToWeddingPlannerQuote < ActiveRecord::Migration
  def change
    add_column :wedding_planner_quotes, :presupuesto_zapatos_novio, :string
    rename_column :wedding_planner_quotes, :presupuesto_zapatos, :presupuesto_zapatos_novia
  end
end
