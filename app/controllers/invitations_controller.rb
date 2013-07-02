class InvitationsController < ApplicationController
  before_filter :set_page_name
  before_filter :signed_in_user, only: [:create]

  def new
    @invitation = Invitation.new
  end

  def create
    
    if params[:invitation][:invite_type] == "bookshelf"
      bookshelf_id = params[:invitation][:bookshelf_id]
      @invitation = current_user.invitations.build(:bookshelf_id => bookshelf_id, :invite_type => "bookshelf")
    else
      @profile = Profile.find_by_id(params[:invitation][:profile_id])
      @invitation = current_user.invitations.build(:profile_id => @profile.id, :invite_type => "book")
    end
    recipient_email = params[:invitation][:recipient_email]
    @invitation.recipient_email = params[:invitation][:recipient_email]
    @invitation.active = true
    @invitation.permission = params[:permission]
    @user_invited = User.find_by_email(params[:invitation][:recipient_email])
    msg = (params[:invitation][:message])

    # Need to verify account first
    if params[:invitation][:invite_type] == "bookshelf"
      if ! @user_invited.blank? and has_bookshelfrelation?(bookshelf_id, @user_invited.id)
        redirect_to root_url, :notice => @invitation.recipient_email + " is already contributing to this bookshelf"
      elsif Invitation.exists?(:recipient_email => params[:invitation][:recipient_email],:profile_id => bookshelf_id)
        @invitation_resent = Invitation.find_by_recipient_email_and_bookshelf_id(recipient_email, bookshelf_id)
        flash[:notice] = "Resending invitation to " + @invitation_resent.recipient_email
        Mailer.delay.invitation_bookshelf(@invitation_resent, current_user, root_url + "bookshelf/" + @invitation_resent.token, msg)
        redirect_to root_url, :notice => "Your invitation has been re-sent to " + @invitation_resent.recipient_email
      elsif @invitation.save
        Mailer.delay.invitation_bookshelf(@invitation, current_user, root_url + "bookshelf/" + @invitation.token, msg)
        redirect_to root_url, :notice => "Your invitation has been sent to " + @invitation.recipient_email
      else
        flash[:error] = "Invalid Email"
        redirect_to root_url
      end
    else
      if ! @user_invited.blank? and has_relationship?(@profile.id, @user_invited.id)
        redirect_to root_url + @profile.url, :notice => @invitation.recipient_email + " is already contributing to this FamilyTales storybook"
      elsif Invitation.exists?(:recipient_email => params[:invitation][:recipient_email],:profile_id => @profile.id)
        @invitation_resent = Invitation.find_by_recipient_email_and_profile_id(params[:invitation][:recipient_email], @profile.id)
        flash[:notice] = "Resending invitation to " + @invitation_resent.recipient_email
        Mailer.delay.invitation(@invitation_resent, @profile, current_user, root_url + @profile.url + "/" + @invitation_resent.token, msg)
        redirect_to root_url + @profile.url, :notice => "Your invitation has been re-sent to " + @invitation_resent.recipient_email
      elsif @invitation.save
        Mailer.delay.invitation(@invitation, @profile, current_user, root_url + @profile.url + "/" + @invitation.token, msg)
        current_user.actionlog!(@profile.id, @page_name, "Invite sent to " + @invitation.recipient_email )
        redirect_to root_url + @profile.url, :notice => "Your invitation has been sent to " + @invitation.recipient_email
      else
        flash[:error] = "Invalid Email"
        redirect_to root_url + @profile.url
      end
    end
  end

  def show
    @invitation = Invitation.find_by_token(params[:invitation_token])
    if @invitation.blank? or ! @invitation.active
      redirect_to root_url, :notice => "That invitation has expired."
    elsif @invitation.invite_type == "bookshelf"
      @bookshelf = Bookshelf.find_by_id(@invitation.bookshelf_id)
    else
      @profile = Profile.find_by_id(@invitation.profile_id)
    end

    @user_check = User.find_by_email(@invitation.recipient_email)
    @sender = User.find_by_id(@invitation.sender_id)
    
    if @invitation.invite_type == "bookshelf" 
      if @bookshelf.blank?
        redirect_to root_url, :notice => "This bookshelf doesn't exists"
      else
        if ! @user_check.blank? 
          sign_in @user_check
          if ! has_bookshelfrelation?(@bookshelf.id, @user_check.id)
            current_user.createbookshelfrelation!(@bookshelf, @invitation.permission)
          end
          flash[:success] = "Hi " + @user_check.first_name + "! You've accepted invitation to the bookshelf " + @bookshelf.name + "."
          redirect_to root_url
        else
          @user = User.new
        end
      end
    elsif @profile.blank?
      redirect_to root_url, :notice => "This storybook doesn't exists"
    elsif ! @user_check.blank? 
      sign_in @user_check 
      if ! has_relationship?(@profile.id, @user_check.id)
        relationship = 1
        current_user.contribute!(@profile, relationship, @invitation.permission == "edit", @invitation.permission)
        current_user.actionlog!(@profile.id, @page_name, "Existing user accepts invitation to storybook" )
        @relationship = Relationship.find_by_user_id_and_profile_id(current_user.id, @profile.id)
        redirect_to edit_relationship_path(@relationship)
      else
        redirect_to root_url + @profile.url
      end
    else
      @user = User.new
    end
  end

  private 

    def set_page_name
      @page_name = "invitation_controller"
    end

end
