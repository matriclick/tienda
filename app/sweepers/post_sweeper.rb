class PostSweeper < ActionController::Caching::Sweeper
  observe Post
  
  def after_save(state)
    expire_cache(state)
  end
  
  def after_destroy(state)
    expire_cache(state)
  end
  
  def expire_cache(state)
    #expire_page :controller => 'javascripts', :action => 'dynamic_states', :format => 'js'
  end
end