module Faalis::Tags
  class Tag < ActiveRecord::Base

    self.table_name = 'faalis_tags'
    acts_as_nested_set scope: [:tagable_id, :tagable_type]

    validates :body, presence: true
    validates :user, presence: true

    # NOTE: install the acts_as_votable plugin if you
    # want user to vote on the quality of tags.
    #acts_as_votable

    belongs_to :tagable, polymorphic: true

    # NOTE: Tags belong to a user
    belongs_to :user, class_name: 'Faalis::User'

    # Helper class method that allows you to build a tag
    # by passing a tagable object, a user_id, and tag text
    # example in readme
    def self.build_from(obj, user_id, tag)
      new \
        tagable: obj,
        body:        tag,
        user_id:     user_id
    end

    #helper method to check if a tag has children
    def has_children?
      self.children.any?
    end

    # Helper class method to lookup all tags assigned
    # to all tagable types for a given user.
    scope :find_tags_by_user, lambda { |user|
      where(user_id: user.id).order('created_at DESC')
    }

    # Helper class method to look up all tags for
    # tagable class name and tagable id.
    scope :find_tags_for_tagable, lambda { |tagable_str, tagable_id|
      where(tagable_type: tagable_str.to_s, tagable_id: tagable_id).order('created_at DESC')
    }

    # Helper class method to look up a tagable object
    # given the tagable class name and id
    def self.find_tagable(tagable_str, tagable_id)
      tagable_str.constantize.find(tagable_id)
    end
  end
end
