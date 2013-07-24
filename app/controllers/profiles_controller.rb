class ProfilesController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: [:edit, :update, :show]
  before_filter :can_edit, only: [:edit, :update]
  before_filter :set_page_name
  
  def new
  	@profile = Profile.new
  end

  def edit
    get_profile
  end

  def destroy
    get_profile

    if current_user.isOwner?(@profile) or current_user.isEditor?(@profile)
      @profile.destroy
    else
      flash[:error] = "You don't have permission to delete this"
    end
    redirect_to root_url
  end


  def update
    get_profile
    if @profile.update_attributes(params[:profile])
      flash[:success] = "Storybook setting updated"
      current_user.actionlog!(@profile.id, @page_name, "update")
      redirect_to root_url + @profile.url
    else
      flash[:error] = "There was an error saving your changes"
      redirect_to edit_profile_path(@profile)
    end
  end

  def getvcf 
    @profile = Profile.find(params[:id])
    full_name = @profile.first_name + "_" + @profile.last_name + "_add_new_story_by_email"
    send_data @profile.get_vcf_file,
      :filename => "#{full_name}.vcf",
      :type => "text/plain"
    Mailer.delay.send_vcf(current_user, @profile, root_url + @profile.url)
  end

  def customize
    message = params[:customize][:message]
    Mailer.delay.customize_request(current_user, message)
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def show
    if ! params[:url].blank?
      @profile = Profile.find_by_url(params[:url])
      if @profile.nil?
        show_error
        return
      end
    else
      begin
        @profile = Profile.find(params[:id])
      rescue
        show_error
        return
      end
    end
    @newchapter = Chapter.new

    if signed_in?
      @relationship = current_user.getRelationship(@profile)
    else
      @relationship = Relationship.new
    end

    if params[:url] == "favicon"
      redirect_back root_url
    else

      if ! signed_in? and @profile.url == "alexdunphy"
        @user = User.find_by_email('familytalesuser2@gmail.com')
        if ! @user.nil?
          sign_in @user
          showprofile
        else
          redirect_to root_url
        end
      elsif ! signed_in?
        flash[:error] = "You can only view that storybook if you are logged in."
        redirect_to login_url
      elsif (( @profile.privacy != 2 ) or 
         ( @profile.privacy == 2 and signed_in? and has_relationship?(@profile.id, current_user.id) ))
        showprofile
        if signed_in?
          current_user.actionlog!(@profile.id, @page_name, "show")
        end
      else
        flash[:error] = "You are not authorized to view that profile"
        redirect_to root_url
      end
    end
  end

  def create

    if params[:profile][:birthday] == nil
      @profile = Profile.new(first_name: params[:profile][:first_name], last_name: params[:profile][:last_name], birthday: Date.today, deathday: Date.today, privacy: 2, bookshelf_id: params[:profile][:bookshelf_id])
    else
      @profile = Profile.new(first_name: params[:profile][:first_name], last_name: params[:profile][:last_name], birthday: (params[:profile][:birthday]) , deathday: Date.today, privacy: 2, bookshelf_id: params[:profile][:bookshelf_id])
    end

    @relationship = params[:relationship][:description]


    respond_to do |format|
      if @profile.save
        current_user.contribute!(@profile, @relationship, true, "edit", true)
        create_chapters
        current_user.actionlog!(@profile.id, @page_name, "create")
        Mailer.delay.new_storybook(current_user, @profile, root_url + @profile.url)
        format.html { redirect_to root_url + @profile.url }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        error_msg = "Sorry, we're not able to create your storybook because of the following " + pluralize(@profile.errors.count, "error") + ":<ul>"
        @profile.errors.full_messages.each do |msg|
          error_msg = error_msg + "<li>" + msg + "</li>"
        end 
        error_msg = error_msg + "</ul>"
        flash[:error] = error_msg
        format.html { redirect_to root_url  }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def create_chapters
      @chapter = @profile.createchapter!("All about " + @profile.first_name, "title")
      @chapter.createpage!(2)
      @chapter = @profile.createchapter!("Great Expectation", "pregnancy")
      @chapter.createpage!(2)
      @chapter = @profile.createchapter!("The 1st month", "1mt")
      @chapter.createpage!(2)
      @chapter = @profile.createchapter!("The 2nd month", "2mt")
      @chapter.createpage!(2)
      @chapter = @profile.createchapter!("The 3rd month", "3mt")
      @chapter.createpage!(2)
      @chapter = @profile.createchapter!("The 4th month", "4mt")
      @chapter.createpage!(2)
      @chapter = @profile.createchapter!("The 5th month", "5mt")
      @chapter.createpage!(2)
      @chapter = @profile.createchapter!("The 6th month", "6mt")
      @chapter.createpage!(2)
      @chapter = @profile.createchapter!("The 7th month", "7mt")
      @chapter.createpage!(2)
      @chapter = @profile.createchapter!("The 8th month", "8mt")
      @chapter.createpage!(2)
      @chapter = @profile.createchapter!("The 9th month", "9mt")
      @chapter.createpage!(2)
      @chapter = @profile.createchapter!("The 10th month", "10mt")
      @chapter.createpage!(2)
      @chapter = @profile.createchapter!("The 11th month", "11mt")
      @chapter.createpage!(2)
      @chapter = @profile.createchapter!("The 12th month", "12mt")
      @chapter.createpage!(2)
    end

    def get_profile
      begin
        @profile = Profile.find(params[:id])
      rescue
        begin
          @profile = Profile.find_by_url(params[:id])
        rescue
         show_error
        end
      end
    end

    def show_error
      redirect_to root_url
    end

    def set_page_name
      @page_name = "storybook_controller"
    end

    def showprofile
      store_location
      @user = current_user
      if current_user.newfeature == true
        current_user.toggle!(:newfeature)
        sign_in @user
      end

      @newpage = Page.new
      @storycomment = Storycomment.new 
      @template_types = Template.all
      
      if signed_in? or is_invited?(params[:invitation_token])
        @memory = @profile.memories.build 
        @invitation = @profile.invitations.build
      end
      
      if @profile.memoryfeed(params[:chapter_num],params[:page_num]).nil?
        flash[:notice] = "That storybook page does not exists. We redirected you the first page of this storybook."
        @chapter = @profile.chapterlist.first
        @page = @chapter.pagelist.first
        @template = Template.find_by_id(@page.template_id)
        @tiles = @template.tilelist
        redirect_to root_url + @profile.url + "/chapter/" + @chapter.chapter_num.to_s
      else
        @memoryfeed_items = @profile.memoryfeed(params[:chapter_num],params[:page_num]).paginate(page: params[:page])
        if ! @profile.chapters.find_by_chapter_num(params[:chapter_num]).nil?
          @chapter = @profile.chapters.find_by_chapter_num(params[:chapter_num])
          if params[:page_num] != nil and ! @chapter.pages.find_by_page_num(params[:page_num]).nil?
            @page = @chapter.pages.find_by_page_num(params[:page_num])
          else
            @page = @chapter.pagelist.first
            if params[:page_num] != nil and @chapter.pages.find_by_page_num(params[:page_num]).nil?
              flash[:notice] = "That storybook page does not exists. We redirected you the first page of this storybook."
            end
          end
        else
          @chapter = @profile.chapterlist.first
          @page = @chapter.pagelist.first
        end
        @template = Template.find_by_id(@page.template_id)

        if ! @chapter.subtype.blank? and ! StorybookQuestion.find_by_subtype(@chapter.subtype).nil?
          if @chapter.chapter_num == 1 and @page.page_num == 1
            @questions = StorybookQuestion.where("subtype = ?",@chapter.subtype).order(:tile_num)
          else
            @questions = StorybookQuestion.where("subtype = ?",@chapter.subtype)
          end
        else
          @questions = StorybookQuestion.all
        end
        @tiles = @template.tilelist
        render :layout => "storyboard_layout"
      end 
    end

    def correct_user
      if ! params[:url].blank?
        @profile = Profile.find_by_url(params[:url])
        if @profile.nil?
          show_error
          return
        end
      else
        begin
          @profile = Profile.find(params[:id])
        rescue
          show_error
          return
        end
      end
      
      if @profile.url != "alexdunphy"
        redirect_to(root_path) unless (current_user.canView?(@profile))
      end
    end

    def can_edit
      if ! params[:url].blank?
        @profile = Profile.find_by_url(params[:url])
        if @profile.nil?
          show_error
          return
        end
      else
        begin
          @profile = Profile.find(params[:id])
        rescue
          show_error
          return
        end
      end
      
      redirect_to(root_path + @profile.url) unless (current_user.isEditor?(@profile))
    end

    def createnewuser
      @invitation = Invitation.find_by_token(params[:invitation_token])
      temppassword = rand(999999).to_s.center(6, rand(9).to_s)
      @user = User.new(email: @invitation.recipient_email, first_name: "Guest",
        last_name: "User",
        password: temppassword, password_confirmation: temppassword )
      @user.save
      @invitation.toggle!(:active)
      sign_in @user
      Mailer.delay.validate_account(current_user, root_url + "login/" + current_user.token)
      @user.contribute!(@profile, "1", false)
    end
end
