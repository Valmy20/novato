module Entity
  class PublicationsController < EntityController
    before_action :set_item, only: %i[edit show update destroy interested visibility]
    layout 'entity_profile'

    def index
      @q = Publication.institution(current_institution)
      @model = @q.order(id: :desc).page(params[:page]).per(10)
    end

    def new
      @model = Publication.new
    end

    def show
    end

    def create
      @model = Publication.new(set_params)

      @model.publicationable_type = 'Institution'
      @model.publicationable_id = current_institution.id
      @model._type = :estagio

      if @model.save
        redirect_to entity_publications_path, notice: 'Publicação adicionada'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @model.update(set_params)
        redirect_to entity_publications_path, notice: 'Publicação atualizada'
      else
        render :edit
      end
    end

    def location
      @model = Publication.find_by(id: params[:id])
      return unless request.patch?
      return unless @model.update(set_params)

      flash[:notice] = 'Local adicionado'
      redirect_to entity_publications_path, notice: 'Local adicionado'
    end

    def destroy
      @model.deleted = true
      (redirect_to entity_publications_path, notice: 'Publicação deletada') if @model.save
    end

    def interested
      @users = Compete.publication_scope(@model).map { |comp| User.find_by(id: comp.user_id) }
    end

    def show_user
      @model = User.find_by(id: params[:id])
    end

    def visibility
      @model.visibility = if @model.visibility
                            false
                          else
                            true
                          end
      return unless @model.approved?

      redirect_to entity_publications_path, notice: 'Alterado' if @model.save
    end

    private

    def set_item
      @model = Publication.friendly.find(params[:id])
    end

    def set_params
      params.require(:publication).permit(
        :title,
        :_type,
        :information,
        :remunaration,
        :vacancies,
        :location
      )
    end
  end
end
