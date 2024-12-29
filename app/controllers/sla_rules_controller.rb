class SlaRulesController < ApplicationController
  before_action :set_sla_rule, only: [ :edit, :update, :destroy ]

  def index
    @sla_rules = SlaRule.all
  end

  def new
    @sla_rule = SlaRule.new
  end

  def create
    @sla_rule = SlaRule.new(sla_rule_params)

    if @sla_rule.save
      redirect_to sla_rules_path
    else
      render :new
    end
  end

  def edit
    @sla_rule = SlaRule.find(params[:id])
  end

  def update
    if @sla_rule.update(sla_rule_params)
      redirect_to sla_rules_path
    else
      render :edit
    end
  end

  def destroy
    @sla_rule.destroy
    redirect_to sla_rules_path
  end

  private

  def sla_rule_params
    params.require(:sla_rule).permit(:filter_type, :filter_value, :inactive_duration, :action_type, :action_details)
  end

  def set_sla_rule
    @sla_rule = SlaRule.find(params[:id])
  end
end
