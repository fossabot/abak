# -*- encoding : utf-8 -*-
module ControllerMacros

    def self.included(base)

        base.extend(ClassMethods)

    end

    module ClassMethods

        def it_renders_404_page_when_post_is_not_found(*actions)

            actions.each do |a|

                it "#{a} renders 404 page when post is not found" do

                    process a, { id: 0 }
                    expect(response).to have_http_status(404)

                end

            end

        end

        def it_renders_404_page_when_category_is_not_found(*actions)

            actions.each do |a|

                it "#{a} renders 404 page when post is not found" do

                    process a, { id: 0 }
                    expect(response).to have_http_status(404)

                end

            end

        end

    end

end
