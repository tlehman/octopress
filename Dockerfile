FROM ubuntu:14.04
MAINTAINER Tobi Lehman <mail@tobilehman.com>

# Install dependencies
RUN apt-get update
RUN apt-get install -y ruby ruby-dev git build-essential python imagemagick texlive-latex-recommended 

# Set correct local
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8

# Create editor userspace
RUN groupadd octopress
RUN useradd octopress -m -g octopress -s /bin/bash
RUN passwd -d -u octopress
RUN echo "octopress ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/octopress
RUN chmod 0440 /etc/sudoers.d/octopress
RUN mkdir /home/octopress/projects
RUN chown octopress:octopress /home/octopress/projects

# Set octopress
RUN gem install bundler
USER octopress
WORKDIR /tmp
# Change your project here (install your project gems version)
RUN git clone https://github.com/tlehman/octopress octopress
WORKDIR /tmp/octopress
RUN bundle install
#RUN rake install

RUN rm -rf /tmp/octopress
# Use vagrant user for the upcoming tasks
CMD ["/bin/bash"]

VOLUME "/home/octopress/octopress"
EXPOSE 4000
WORKDIR /home/octopress/octopress
