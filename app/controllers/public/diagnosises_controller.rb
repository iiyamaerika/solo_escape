class Public::DiagnosisesController < ApplicationController
  
  def index
  end

  def new
    @diagnosis = Diagnosis.new
  end

  def show
    @diagnosis = Diagnosis.find_by(id: params[:id])
    # byebug
  end

  def create
    @diagnosis = Diagnosis.new(diagnosis_params)
    params[:diagnosis][:question] ? @diagnosis.question = params[:diagnosis][:question].join("") : false
    if @diagnosis.save
        flash[:notice] = "診断が完了しました"
        redirect_to diagnosise_path(@diagnosis.id)
    else
        redirect_to :action => "new"
    end
  end

private
  def diagnosis_params
      params.require(:diagnosis).permit(:id, question: [])
  end
  
end
