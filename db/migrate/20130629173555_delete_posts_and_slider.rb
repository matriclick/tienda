class DeletePostsAndSlider < ActiveRecord::Migration
  def up
    p = Post.where('title not like "%peplum%"')
    puts 'DELETE Post.where(title not like "%peplum%")'
    p.each do |post|
      puts post.title
      post.destroy
    end
    
    s = SliderImage.all
    puts 'DELETE SliderImage.all'
    s.each do |si|
      puts si.id
      si.destroy
    end
    
    s = SliderImageType.all
    puts 'DELETE SliderImageType.all'
    s.each do |si|
      puts si.name
      si.destroy
    end
    
  end

  def down
  end
end
