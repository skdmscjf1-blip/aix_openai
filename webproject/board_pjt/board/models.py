from django.db import models

# BNO      NOT NULL NUMBER(4)      
# ID                VARCHAR2(100)  
# BTITLE            VARCHAR2(1000) 
# BCONTENT          CLOB           
# BGROUP            NUMBER(4)      
# BSTEP             NUMBER(4)      
# BINDENT           NUMBER(4)      
# BHIT              NUMBER(4)      
# BDATE             DATE           
# RANK              NUMBER(10)

class Board(models.Model):
    bno = models.AutoField(primary_key=True)
    id = models.CharField(max_length=100)
    btitle = models.CharField(max_length=1000)
    bcontent = models.TextField()
    bgroup = models.IntegerField(default=0)
    bstep = models.IntegerField(default=0)
    bindent = models.IntegerField(default=0)
    bhit = models.IntegerField(default=0)
    bdate = models.DateTimeField(auto_now=True,blank=True)

    def __str__(self):
        return f'{self.bno},{self.id},{self.btitle}'
