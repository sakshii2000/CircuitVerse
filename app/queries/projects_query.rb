# frozen_string_literal: true

class ProjectsQuery
  MAX_RESULTS_PER_PAGE = 5

  attr_reader :relation

  def initialize(relation = Project.all)
    @search = Search.new(relation)
  end

  def execute(query)
    @search.call(query).includes(:author, :tags)
      .select("id,author_id,image_preview,name,description,view")
  end

  def results(query_params)
    execute(query_params[:q]).paginate(page: query_params[:page],
        per_page: MAX_RESULTS_PER_PAGE)
  end
end
