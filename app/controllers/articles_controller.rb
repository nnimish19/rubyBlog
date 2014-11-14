class ArticlesController < ApplicationController

  #-----------------------------------------------------------------
  def new
    @article = Article.new
  end

  #-----------------------------------------------------------------
  def create
    #Models in Rails use a singular name, and their corresponding database tables use a plural name.
    #$ bin/rails generate model Article title:string text:text
    #Model: Article, corresponding DB: articles

    #render plain: params[:article].inspect
    #@article = Article.new(params[:article])

    #IMP
    #The reason why we added @article = Article.new in the ArticlesController is that otherwise @article would be nil
    #in our view, and calling @article.errors.any? would throw an error.

    @article = Article.new(article_params)    #CREATING NEW Article OBJECT.
    if @article.save           #The reason why we added @article = Article.new in the ArticlesController is that otherwise @article would be nil in our view, and calling @article.errors.any? would throw an error.cle.save returns a boolean indicating whether the article was saved or not.
      redirect_to @article     #looks for action "show". see $rake routes
    else
      render 'new'
    end
    #This rendering is done within the same request as the form submission, whereas the redirect_to will tell
    #the browser to issue another request.
  end

  #=====================================================================================
  def index
    @articles = Article.all
  end

  #-----------------------------------------------------------------
  def show
    #find function returns an Article object
    #We also use an instance variable (prefixed by @) to hold a reference to the article object
    @article = Article.find(params[:id])
  end

  #-----------------------------------------------------------------
  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  #-----------------------------------------------------------------
  private
    def article_params
      params.require(:article).permit(:title, :text)    #(remember that params[:article] contains the attributes we're interested in
    end

end
