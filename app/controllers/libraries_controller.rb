class LibrariesController < ApplicationController
  before_action :set_library, only: [:show, :edit, :update, :destroy]

  # GET /libraries/1/edit
  def edit
  end

  # POST /libraries
  # POST /libraries.json
  def create
    @lib = Library.new(library_params)

    if @lib.save
      redirect_to controller: "home", action: "index", notice: 'Library was successfully created.'
    end
  end

  # PATCH/PUT /libraries/1
  # PATCH/PUT /libraries/1.json
  def update
    if @lib.update(library_params)
      redirect_to controller: "home", action: "index", notice: 'Library was successfully updated.'
    end
  end

  # DELETE /libraries/1
  # DELETE /libraries/1.json
  def destroy
    @lib.destroy
    redirect_to libraries_url, notice: 'Library was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @lib = Library.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_params
      params.require(:library).permit(:name)
    end
end
