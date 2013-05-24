class ExpensesController < ApplicationController
	before_filter :authenticate_user!
  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = current_user.user_account.expenses
    #DZF get totals
		unless @expenses.blank?
			@expense_total_price = current_user.user_account.get_expenses_total_price
			@expense_total_payed_price = current_user.user_account.get_expenses_total_total_payed_price
			@expense_total_payed_percentage = @expense_total_payed_price / @expense_total_price * 100
			@expense_total_remaining_price = current_user.user_account.get_expenses_total_remaining_price
			#DZF get payers percentage
			@payer_types_totals = {}
			PayerType.all.each do |pt|
				@payer_types_totals.merge!({pt.name => (current_user.user_account.get_payer_total_price_by_id(pt.id) * 100 / @expense_total_price) } )
			end
		end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
    @expense = Expense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.json
  def new
    @expense = Expense.new
		PayerType.all.each do |pt|
			@expense.payers.build payer_type_id: pt.id
		end
		@expense.wants_points = true if params[:wants_points]
		
    respond_to do |format|
      format.html { render :layout => false }
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])

		respond_to do |format|
      format.html { render :layout => false }
    end
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(params[:expense])
		@expense.user_account_id = current_user.user_account.id
		
    respond_to do |format|
      if @expense.save
				if @expense.wants_points
					NoticeMailer.matriclick_points_email(current_user, @expense).deliver
					format.html {redirect_to points_url, notice: "Ya tenemos el gasto que acabas de ingresar. Te enviaremos un email luego de validar tus puntos."}
				else
        format.html { redirect_to expenses_url, notice: 'Expense was successfully created.' }
				end
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.json
  def update
    @expense = Expense.find(params[:id])

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        format.html { redirect_to expenses_url, notice: 'Expense was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :ok }
    end
  end


	def statistics
		@expenses = current_user.user_account.expenses
		@my_graph_data =  ["{\"title\":\"Tu matrimonio\",\"div\":\"my_chart\",\"type\":\"pie\",\"legend\":\"right\",\"width\":640,\"height\":480,\"var_name\":\"Gasto\"}"]
		unless @expenses.blank?
			hash = @expenses.grouped_by_industry_category_hash
			hash.each do |k, v|
				total = 0
				v.each { |e| total += e.price * e.quantity }
				@my_graph_data.push("{\"name\":\""+(v.first.industry_category.blank? ? v.first.industry_category_name : v.first.industry_category.get_name)+"\",\"quantity\":"+total.to_s+"}")
			end
		end		
	end
	
	def points
	end

	def filter_supplier_accounts
		@supplier_accounts = SupplierAccount.by_industry_category(params[:id]).approved
		render json: @supplier_accounts.map {|sa| {"id" => sa.id, "name" => sa.fantasy_name}}
	end
end
