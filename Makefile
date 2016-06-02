APP=slave
all: $(APP)
JRUBYJAR="$(HOME)/.rvm/rubies/jruby-1.*/lib/jruby.jar"
JAVA_JAR="jar"
JAVA_FUNC="org.drftpd.slave.Slave"
CLEANUP=build.log ./_* *.zip 
all: $(APP)

clean: 
	@rm -fR $(CLEANUP) 2>/dev/null
	

	
docker-wercker-base:
	@docker build -t nated/wercker-base Dockerfiles/wercker-base/
	
docker-push:
	@docker login 
	@docker push nated/wercker-base


makejar:
	@cp $(JRUBYJAR) $(APP).jar
	@ls -lah $(APP).jar
	@echo "..."
	@$(JAVA_JAR) -uf $(APP).jar -C classes .
	@ls -lah $(APP).jar
	@echo "Packing done ..."


slave: makejar
	@@$(JAVA_JAR) -ufe $(APP).jar $(JAVA_FUNC)
	@ls -lah $(APP).jar
	@echo "Done..."
	




