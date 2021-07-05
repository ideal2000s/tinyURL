# frozen_string_literal: true

class LinksController < ApplicationController # rubocop:disable Style/Documentation
  # GET /links
  def index
    links = Link.all
    render :index, locals: { links: links }
  end

  # GET /links/new
  def new
    link = Link.new
    render :new, locals: { link: link }
  end

  # POST /links
  def create
    link = Link.new(original_url: "https://#{link_params[:domain]}")
    if link.save
      redirect_to links_path, notice: 'Link was successfully created.'
    else
      render :new, locals: { link: link }
    end
  end

  # GET /links/:path
  def redirect # rubocop:disable Metrics/AbcSize
    if link
      link.ip_addresses << request.remote_ip unless link.ip_addresses.include?(request.remote_ip)
      link.save
      redirect_to link.original_url
    else
      redirect_back(fallback_location: links_path, notice: "Can't find link with given short_url")
    end
  end

  # GET /links/:path/info
  def show
    if link
      render :show, locals: { link: link }
    else
      redirect_back(fallback_location: links_path, notice: "Can't find link with given short_url")
    end
  end

  private

  def link
    @link ||= Link.find_by(short_url: params[:path])
  end

  def link_params
    params.require(:link).permit(:domain)
  end
end
