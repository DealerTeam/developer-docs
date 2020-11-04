public with sharing class FinanceAPI {
    public FinanceAPI() {
    }

	public static Decimal calculateMonthlyPayment(Decimal principle, Decimal rate, Decimal term, Decimal days){
		try{
			days = days != null ? days : 0;
			Double r = (double)rate/12/100;
			Decimal payment = (principle) * (r * (Math.pow(1+r,(double)term) /( Math.pow(1+r,(double)term) -1)) );
			if(days > 30){
				Decimal an = (1 - 1/ Math.pow(1+r, (double)term)) / r;
				Decimal add = an * (1+r);
				payment = (principle) * (1 + (days / 30) * r) / add;
			}
			return payment;
		} catch (Exception e){
			return 0;
		}
	}

    public class financeTable{
        private Decimal step = 0.75;
	    private List<Decimal> terms = new List<Decimal>{36,48,60,72};
		@AuraEnabled public financeTableHeader header;
		@AuraEnabled public List<financeTableRow> rows;

    public financeTable(Decimal principle, Decimal down, Decimal rate, Decimal increment, Decimal days){
			this.header = new financeTableHeader(down, down+increment, down+(increment * 2), down+(increment * 3));
            principle = principle != null ? principle : 0;
			down = down != null ? down : 0;
            rate = rate != null ? rate : 0;
            increment = increment != null ? increment : 500;
			List<financeTableRow> rows = new List<financeTableRow>();
			for(Decimal term : this.terms){
				Double r = (double)rate/12/100;
				Decimal increment1 = (principle-down) * (r * (Math.pow(1+r,(double)term) /( Math.pow(1+r,(double)term) -1)) );
				Decimal increment2 = (principle - (down+increment)) * (r * (Math.pow(1+r,(double)term) /( Math.pow(1+r,(double)term) -1)) );
				Decimal increment3 = (principle - (down+(increment*2))) * (r * (Math.pow(1+r,(double)term) /( Math.pow(1+r,(double)term) -1)) );
				Decimal increment4 = (principle - (down+(increment*3))) * (r * (Math.pow(1+r,(double)term) /( Math.pow(1+r,(double)term) -1)) );

				if(days > 30){
					Decimal an = (1 - 1/ Math.pow(1+r, (double)term)) / r;
					Decimal add = an * (1+r);
					increment1 = (principle-down) * (1 + (days / 30) * r) / add;
					increment2 = (principle - (down+increment)) * (1 + days / 30 * r) / add;
					increment3 = (principle - (down+(increment*2))) * (1 + days / 30 * r) / add;
					increment4 = (principle - (down+(increment*3))) * (1 + days / 30 * r) / add;
				}

				rows.add(new financeTableRow(
					term,
					rate,
					increment1,
					increment2,
					increment3,
					increment4
				));
				rate = rate + step;
			}
			this.rows = rows;
		}

	}
	public class financeTableHeader{
		@AuraEnabled public String term = 'Term';
		@AuraEnabled public String rate = 'Rate';
		@AuraEnabled public Decimal increment1;
		@AuraEnabled public Decimal increment2;
		@AuraEnabled public Decimal increment3;
		@AuraEnabled public Decimal increment4;

		public financeTableHeader(Decimal increment1, Decimal increment2, Decimal increment3, Decimal increment4){
			this.increment1 = increment1;
			this.increment2 = increment2;
			this.increment3 = increment3;
			this.increment4 = increment4;
		}
	}
	public class financeTableRow{
		@AuraEnabled public Decimal term;
		@AuraEnabled public Decimal rate;
		@AuraEnabled public Decimal payment1;
		@AuraEnabled public Decimal payment2;
		@AuraEnabled public Decimal payment3;
		@AuraEnabled public Decimal payment4;

		public financeTableRow(Decimal term, Decimal rate, Decimal payment1, Decimal payment2, Decimal payment3, Decimal payment4){
			this.term = term;
			this.rate = rate;
			this.payment1 = payment1.setScale(2);
			this.payment2 = payment2.setScale(2);
			this.payment3 = payment3.setScale(2);
			this.payment4 = payment4.setScale(2);
		}

	}
}