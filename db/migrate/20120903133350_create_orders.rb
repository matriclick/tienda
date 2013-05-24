class CreateOrders < ActiveRecord::Migration

  def self.up
    create_table :orders do |t|
      t.string :tbk_tipo_transaccion
      t.string :tbk_respuesta
      t.string :tbk_id_sesion
      t.string :tbk_codigo_autorizacion
      t.string :tbk_monto
      t.string :tbk_final_numero_tarjeta
      t.string :tbk_fecha_expiracion
      t.string :tbk_fecha_contable
      t.string :tbk_fecha_transaccion
      t.string :tbk_hora_transaccion
      t.string :tbk_id_transaccion
      t.string :tbk_tipo_pago
      t.string :tbk_numero_cuotas
      t.string :tbk_mac
      t.string :tbk_tasa_interes_max

      t.timestamps
    end
  end
  
  def self.down
    drop_table :webpay_transactions
  end

end